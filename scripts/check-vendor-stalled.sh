#!/usr/bin/env bash
set -euo pipefail

# check-vendor-stalled.sh - List remote add/* branches still stuck at the
# vendor-only stage of the add-plugin workflow.
#
# Runnable from anywhere: the script cds into the Neovim config repository
# root (the parent of this script's directory) before inspecting refs, so the
# result does not depend on the caller's working directory.
#
# Background:
#   The add-plugin skill defaults to vendor-only mode. It vendors the plugin
#   source into <plugin>/CODES (plus WIKIS) and copies lazy.nvim spec
#   templates whose `TODO: it` markers are left untouched, as a marker commit
#   plus one or more "wip" commits. Running the skill with --fill afterwards
#   fills the spec in and squashes the wip commits into a single feat: commit.
#   Two signals therefore tell the two states apart, per branch:
#
#     todo - number of .lua files the branch adds (excluding CODES/ and WIKIS/)
#            that still contain a `TODO: it` marker  -> spec not filled in
#     wip  - number of commits whose subject is exactly "wip"
#            -> not squashed yet
#
#   Class  Condition            Meaning
#     A    todo > 0, wip > 0    stalled at vendoring, nothing done since
#     B    todo > 0, wip = 0    partially filled but already squashed
#     C    todo = 0, wip > 0    spec filled in, squash still pending
#     D    todo = 0, wip = 0    finished shape
#
# Usage:
#   scripts/check-vendor-stalled.sh                  # class A, newest first
#   scripts/check-vendor-stalled.sh --class C
#   scripts/check-vendor-stalled.sh --class all
#   scripts/check-vendor-stalled.sh --names          # branch names only
#   scripts/check-vendor-stalled.sh --fetch          # refresh remote refs first
#   task check-vendor-stalled
#   task cvs -- --class C
#
# Options:
#   --class A|B|C|D|all   Which class to list (default: A)
#   --names               Print bare branch names, one per line (pipe-friendly)
#   --fetch               Run `git fetch --prune <remote>` before inspecting
#   --base <ref>          Base ref to diff against (default: master)
#   --remote <name>       Remote to inspect (default: origin)
#   -h, --help            Show this help
#
# Exit code: always 0 on success. This is an inventory, not a lint; branches
# being stalled is the normal state and must not fail a task pipeline.

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(dirname "${SCRIPT_DIR}")"

cd "${REPO_ROOT}"

# Usage: usage
# Description: Print the Usage/Options block of this file's header comment.
# Returns: always 0
usage() {
    awk '/^readonly SCRIPT_DIR=/ { exit }
         /^# Usage:/ { show = 1 }
         show { sub(/^# ?/, ""); print }' "${BASH_SOURCE[0]}"
}

class_filter="A"
names_only=0
do_fetch=0
base="master"
remote="origin"

while (($# > 0)); do
    case "$1" in
        --class)
            class_filter="${2:?Error: --class requires a value}"
            shift 2
            ;;
        --class=*)
            class_filter="${1#--class=}"
            shift
            ;;
        --names)
            names_only=1
            shift
            ;;
        --fetch)
            do_fetch=1
            shift
            ;;
        --base)
            base="${2:?Error: --base requires a value}"
            shift 2
            ;;
        --base=*)
            base="${1#--base=}"
            shift
            ;;
        --remote)
            remote="${2:?Error: --remote requires a value}"
            shift 2
            ;;
        --remote=*)
            remote="${1#--remote=}"
            shift
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            echo "Error: unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

case "${class_filter}" in
    A | B | C | D | all) ;;
    *)
        echo "Error: --class must be one of A, B, C, D, all (got: ${class_filter})" >&2
        exit 2
        ;;
esac

if ((do_fetch)); then
    git fetch --prune "${remote}" >/dev/null 2>&1 ||
        echo "Warning: git fetch --prune ${remote} failed; using cached refs" >&2
fi

readonly base_ref="${remote}/${base}"

if ! git rev-parse --verify --quiet "${base_ref}" >/dev/null; then
    echo "Error: base ref not found: ${base_ref}" >&2
    exit 2
fi

# Usage: classify_branch <full-ref>
# Description: Echo "<class>\t<short-name>\t<date>\t<todo>\t<wip>" for one branch.
classify_branch() {
    local ref="${1:?Error: ref required}"
    local todo=0 wip=0 file class

    while IFS= read -r file; do
        case "${file}" in
            */CODES/* | */WIKIS/*) continue ;;
            *.lua) ;;
            *) continue ;;
        esac
        if git show "${ref}:${file}" 2>/dev/null | grep -q 'TODO: it'; then
            todo=$((todo + 1))
        fi
    done < <(git diff --name-only "${base_ref}...${ref}")

    wip=$(git log --format='%s' "${base_ref}..${ref}" | grep -c '^wip$' || true)

    if ((todo > 0)); then
        ((wip > 0)) && class="A" || class="B"
    else
        ((wip > 0)) && class="C" || class="D"
    fi

    printf '%s\t%s\t%s\t%s\t%s\n' \
        "${class}" \
        "${ref#"${remote}"/}" \
        "$(git log -1 --format='%cs' "${ref}")" \
        "${todo}" \
        "${wip}"
}

rows=""
while IFS= read -r ref; do
    rows+="$(classify_branch "${ref}")"$'\n'
done < <(git for-each-ref --format='%(refname:short)' "refs/remotes/${remote}/add")

if [[ -z "${rows//[$'\n\t ']/}" ]]; then
    echo "No ${remote}/add/* branches found." >&2
    exit 0
fi

# Selected rows, newest commit first.
selected=$(printf '%s' "${rows}" | awk -F'\t' -v c="${class_filter}" \
    'NF && (c == "all" || $1 == c)' | sort -t$'\t' -k3,3r -k2,2)

if ((names_only)); then
    printf '%s' "${selected}" | awk -F'\t' 'NF {print $2}'
    exit 0
fi

if [[ -n "${selected//[$'\n\t ']/}" ]]; then
    printf '%s' "${selected}" |
        awk -F'\t' 'NF {printf "%s  %-34s (class=%s todo=%s wip=%s)\n", $3, $2, $1, $4, $5}'
else
    echo "(no branches in class ${class_filter})"
fi

printf '\n'
printf '%s' "${rows}" | awk -F'\t' '
NF { n[$1]++; total++ }
END {
    printf "A stalled at vendoring : %d\n", n["A"]
    printf "B filled but squashed  : %d\n", n["B"]
    printf "C spec done, no squash : %d\n", n["C"]
    printf "D finished shape       : %d\n", n["D"]
    printf "total                  : %d\n", total
}'
