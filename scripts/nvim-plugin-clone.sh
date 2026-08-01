#!/usr/bin/env bash
set -euo pipefail

# nvim-plugin-clone.sh - Vendor Neovim plugin sources into lua/plugins.
#
# Runnable from anywhere: the script cds into PLUGINS_DIR (default:
# ~/.config/nvim/lua/plugins) before doing any work, so branches are
# created in the Neovim config repository and plugins are vendored
# under lua/plugins regardless of the caller's working directory.
#
# For each given git URL, this script creates an independent branch
# `add/<plugin-dir>` from the current branch and commits:
#   1. An empty marker commit: "feat: add <owner>/<repo>"
#   2. The plugin source under <plugin-dir>/CODES (history stripped) as "wip"
#   3. The GitHub wiki under <plugin-dir>/WIKIS if one exists, as "wip"
#   4. lazy.nvim spec templates copied next to CODES/, as "wip"
# Squash the wip commits into the marker commit via rebase before opening a PR.
#
# The spec templates ship three init variants, one per plugin tree, because
# each requires its sibling spec files under a different module prefix
# ("plugins.", "colorschemes.", "denops-plugins."). Only the variant matching
# PLUGINS_DIR is installed, as init.lua; see init_template_for().
#
# Usage:
#   nvim-plugin-clone <git-url>...
#   task plugin-setup -- <git-url>...
#   task colorscheme-setup -- <git-url>...
#   task denops-plugin-setup -- <git-url>...
#
# Examples:
#   nvim-plugin-clone https://github.com/xeind/vallow.nvim.git
#   nvim-plugin-clone \
#     https://github.com/ryanmab/onoma.nvim.git \
#     https://github.com/zeybek/camouflage.nvim.git
#   NVIM_PLUGINS_DIR=~/.config/nvim/lua/colorschemes \
#     nvim-plugin-clone https://github.com/vague-theme/vague.nvim

readonly TEMPLATE_DIR="${NVIM_PLUGIN_TEMPLATE_DIR:-${HOME}/NVIM_PLUGIN_TEMPLATES}"
readonly PLUGINS_DIR="${NVIM_PLUGINS_DIR:-${HOME}/.config/nvim/lua/plugins}"

# Never fall back to interactive credential prompts (e.g. probing a
# nonexistent wiki repository would otherwise hang asking for a username).
export GIT_TERMINAL_PROMPT=0

# Usage: usage
# Description: Print usage information to stderr
# Returns: always 0
usage() {
    cat >&2 <<EOF
Usage: ${0##*/} <git-url>...

Vendor each plugin into ${PLUGINS_DIR}/<repo-name>/CODES (and WIKIS if a
GitHub wiki exists) on its own add/<repo-name> branch, with lazy.nvim spec
templates copied from: ${TEMPLATE_DIR}

Runnable from any directory; override the target with NVIM_PLUGINS_DIR.
EOF
}

# Usage: init_template_for <plugins_dir>
# Description: Echo the init template variant whose require() prefix matches
#              the target plugin tree. Installing the wrong one leaves the
#              spec requiring its siblings under a prefix that does not exist.
# Returns: always 0
init_template_for() {
    local plugins_dir="${1:?Error: plugins_dir required}"

    case "${plugins_dir##*/}" in
        colorschemes) echo "init_colorschemes.lua" ;;
        denops-plugins) echo "init_denops.lua" ;;
        plugins) echo "init.lua" ;;
        *)
            echo "INFO: unknown target tree '${plugins_dir##*/}', using init.lua" >&2
            echo "init.lua"
            ;;
    esac
}

# Usage: copy_templates <dir_name> <owner_repo> <init_template>
# Description: Copy lazy.nvim spec templates into <dir_name>/ (excluding
#              .git/.jj), keep only <init_template> as init.lua, and replace
#              placeholders in it
# Returns: 0 on success, non-zero on error
copy_templates() {
    local dir_name="${1:?Error: dir_name required}"
    local owner_repo="${2:?Error: owner_repo required}"
    local init_template="${3:?Error: init_template required}"

    cp "${TEMPLATE_DIR}"/*.lua "${dir_name}/"
    cp "${TEMPLATE_DIR}/.editorconfig" "${TEMPLATE_DIR}/stylua.toml" "${dir_name}/"

    # Finished specs carry exactly one init.lua in every tree, so drop the
    # variants that do not apply here instead of shipping all three.
    if [[ "${init_template}" != "init.lua" ]]; then
        mv -f "${dir_name}/${init_template}" "${dir_name}/init.lua"
    fi
    rm -f "${dir_name}/init_colorschemes.lua" "${dir_name}/init_denops.lua"

    # Fill in the spec template for this plugin
    sed -i \
        -e "s/PLUGIN_NAME/${dir_name}/g" \
        -e "s|mimikun/spec-template|${owner_repo}|g" \
        "${dir_name}/init.lua"
}

# Usage: process_plugin <git_url> <base_branch> <init_template>
# Description: Create branch add/<dir>, vendor CODES/WIKIS, copy templates,
#              and commit each step (empty feat marker, then wip commits)
# Returns: 0 on success, 1 if skipped (existing branch/directory)
process_plugin() {
    local url="${1:?Error: url required}"
    local base_branch="${2:?Error: base_branch required}"
    local init_template="${3:?Error: init_template required}"

    # Normalize the URL: tolerate trailing slashes and a missing .git suffix.
    # A wiki URL (<repo>.wiki[.git]) is folded into its parent repository,
    # since wikis are auto-detected from the parent below.
    local base
    base="$(echo "${url}" | sed -E 's#/+$##; s#\.git$##; s#\.wiki$##')"

    local owner_repo dir_name clone_url wiki_url branch
    owner_repo="$(echo "${base}" | sed -E 's#^.*[:/]([^/]+/[^/]+)$#\1#')"
    if [[ ! "${url}" =~ ^(https?://|ssh://|git://|git@) ]] ||
        [[ ! "${owner_repo}" =~ ^[^/:]+/[^/:]+$ ]]; then
        echo "SKIP: unrecognized URL '${url}'" >&2
        return 1
    fi
    dir_name="${owner_repo##*/}"
    dir_name="${dir_name//./-}"
    clone_url="${base}.git"
    wiki_url="${base}.wiki.git"
    branch="add/${dir_name}"

    if git show-ref --verify --quiet "refs/heads/${branch}"; then
        echo "SKIP: branch '${branch}' already exists (${url})" >&2
        return 1
    fi
    if [[ -e "${dir_name}" ]]; then
        echo "SKIP: directory '${dir_name}' already exists (${url})" >&2
        return 1
    fi

    echo "==> ${owner_repo} -> ${dir_name} (${branch})"
    git switch -c "${branch}" "${base_branch}"

    # Empty marker commit; the wip commits below get squashed into it later
    git commit --allow-empty -nm "feat: add ${owner_repo}"

    # Vendor the plugin source without its history
    git clone --depth 1 "${clone_url}" "${dir_name}/CODES"
    rm -rf "${dir_name}/CODES/.git"
    # -f: vendored sources may ship their own .gitignore (e.g. ignoring docs/);
    # we want every file committed regardless
    git add -f "${dir_name}"
    git commit -nm "wip"

    # Vendor the GitHub wiki only when one exists
    if git ls-remote --exit-code "${wiki_url}" >/dev/null 2>&1; then
        git clone --depth 1 "${wiki_url}" "${dir_name}/WIKIS"
        rm -rf "${dir_name}/WIKIS/.git"
        git add -f "${dir_name}"
        git commit -nm "wip"
    else
        echo "INFO: no wiki found for ${owner_repo}"
    fi

    copy_templates "${dir_name}" "${owner_repo}" "${init_template}"
    git add -f "${dir_name}"
    git commit -nm "wip"

    git switch "${base_branch}"
}

main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi

    if [[ ! -d "${TEMPLATE_DIR}" ]]; then
        echo "Error: template directory not found: ${TEMPLATE_DIR}" >&2
        exit 1
    fi

    if [[ ! -d "${PLUGINS_DIR}" ]]; then
        echo "Error: plugins directory not found: ${PLUGINS_DIR}" >&2
        exit 1
    fi

    # All git operations and vendored paths below are relative to the
    # plugins directory, so the script works from any calling directory.
    cd "${PLUGINS_DIR}"

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: not inside a git repository: ${PLUGINS_DIR}" >&2
        exit 1
    fi

    local base_branch
    base_branch="$(git branch --show-current)"
    if [[ -z "${base_branch}" ]]; then
        echo "Error: detached HEAD; switch to a branch first" >&2
        exit 1
    fi

    local init_template
    init_template="$(init_template_for "${PLUGINS_DIR}")"
    echo "INFO: target ${PLUGINS_DIR} -> spec template ${init_template}"

    local url
    for url in "$@"; do
        process_plugin "${url}" "${base_branch}" "${init_template}" || true
    done

    echo
    echo "Created branches:"
    git branch --list 'add/*'
    echo "Remember: squash the wip commits into the feat commit (git rebase -i) before opening a PR."
}

main "$@"
