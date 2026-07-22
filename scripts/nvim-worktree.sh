#!/usr/bin/env bash
set -euo pipefail

# nvim-worktree.sh - Manage parallel Neovim-config git worktrees isolated by
# NVIM_APPNAME.
#
# Each worktree lives at ~/.config/nvim-<name>, a sibling of the main config.
# That single location satisfies two independent best practices at once:
#   - git worktree: keep linked worktrees as siblings of the main clone
#     (never nested inside it, which breaks .git resolution)
#   - Neovim NVIM_APPNAME: alternate configs live at ~/.config/nvim-*
# so `NVIM_APPNAME=nvim-<name> nvim` (or just `cd`-ing in when the generated
# .envrc + direnv are active) loads the worktree as a fully isolated config.
#
# Data isolation (avoids re-downloading everything on first launch, since
# NVIM_APPNAME also redirects stdpath("data")):
#   - lazy/ (plugins) and site/ (treesitter parsers) are real copies
#   - mason/ (large LSP/tool binaries) is a symlink back to the main data dir
#     so it is shared, not duplicated. Uninstalling via :Mason inside a
#     worktree therefore affects the shared store.
#
# Runnable from anywhere: it resolves the main config repo as the parent of
# this script's directory, so all git commands target the right repository.
#
# Usage:
#   scripts/nvim-worktree.sh add <branch> [name]
#   scripts/nvim-worktree.sh remove <name> [--force]
#   scripts/nvim-worktree.sh list
#
# Examples:
#   scripts/nvim-worktree.sh add add/prompt-nvim       # -> ~/.config/nvim-prompt
#   scripts/nvim-worktree.sh add feature/x myconfig    # -> ~/.config/nvim-myconfig
#   scripts/nvim-worktree.sh remove prompt             # remove worktree + data
#   scripts/nvim-worktree.sh list
#
# Note: `remove` deletes the worktree and its per-app data/state/cache dirs but
# NEVER deletes the git branch (merging to master stays a manual decision).
#
# XDG overrides are honoured (XDG_CONFIG_HOME / XDG_DATA_HOME / ...).

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(dirname "${SCRIPT_DIR}")"

readonly CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
readonly CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
readonly MAIN_APP="nvim"

# Real-copy these subdirs of the main data dir; symlink-share these.
readonly COPY_DIRS=(lazy site)
readonly LINK_DIRS=(mason)

die() {
    printf 'error: %s\n' "$*" >&2
    exit 1
}

usage() {
    sed -n '5,40p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
    exit "${1:-0}"
}

# Derive a short app name from a branch: add/prompt-nvim -> prompt
derive_name() {
    local n="${1##*/}"   # after last slash
    n="${n%-nvim}"       # strip trailing -nvim
    n="${n%.nvim}"       # strip trailing .nvim
    printf '%s' "${n}"
}

# Seed a fresh per-app data dir so lazy/mason/treesitter are reused, not
# re-fetched. Existing entries are left untouched (idempotent).
seed_data() {
    local appname="$1"
    local src="${DATA_HOME}/${MAIN_APP}"
    local dst="${DATA_HOME}/${appname}"

    [ -d "${src}" ] || {
        printf 'note: main data dir %s not found; skipping seed\n' "${src}"
        return 0
    }
    mkdir -p "${dst}"

    local d
    for d in "${COPY_DIRS[@]}"; do
        if [ -d "${src}/${d}" ] && [ ! -e "${dst}/${d}" ]; then
            printf '  copy   %s\n' "${d}"
            cp -r "${src}/${d}" "${dst}/${d}"
        fi
    done
    for d in "${LINK_DIRS[@]}"; do
        if [ -e "${src}/${d}" ] && [ ! -e "${dst}/${d}" ]; then
            printf '  link   %s -> %s\n' "${d}" "${src}/${d}"
            ln -s "${src}/${d}" "${dst}/${d}"
        fi
    done
}

# Write .envrc for direnv auto-activation and keep it out of git.
write_envrc() {
    local wt="$1" appname="$2"
    local envrc="${wt}/.envrc"

    if [ ! -e "${envrc}" ]; then
        printf 'export NVIM_APPNAME=%s\n' "${appname}" > "${envrc}"
        printf '  write  .envrc (NVIM_APPNAME=%s)\n' "${appname}"
    fi

    # Exclude .envrc from git without committing. info/exclude lives in the
    # common git dir, so this covers every worktree at once.
    local exclude
    exclude="$(git -C "${REPO_ROOT}" rev-parse --git-common-dir)/info/exclude"
    if [ -f "${exclude}" ] && ! grep -qxF '.envrc' "${exclude}"; then
        printf '.envrc\n' >> "${exclude}"
    fi

    if command -v direnv >/dev/null 2>&1; then
        ( cd "${wt}" && direnv allow . ) && printf '  direnv allow\n'
    else
        printf '  note: direnv not found; run `NVIM_APPNAME=%s nvim` manually\n' "${appname}"
    fi
}

cmd_add() {
    local branch="${1:-}"
    [ -n "${branch}" ] || die "add: <branch> required"
    local name="${2:-$(derive_name "${branch}")}"
    local appname="nvim-${name}"
    local wt="${CONFIG_HOME}/${appname}"

    [ -e "${wt}" ] && die "already exists: ${wt}"

    printf 'creating worktree %s -> %s\n' "${appname}" "${branch}"
    git -C "${REPO_ROOT}" worktree add "${wt}" "${branch}"
    seed_data "${appname}"
    write_envrc "${wt}" "${appname}"
    printf 'done. launch: NVIM_APPNAME=%s nvim   (or cd %s)\n' "${appname}" "${wt}"
}

cmd_remove() {
    local name="${1:-}"
    [ -n "${name}" ] || die "remove: <name> required"
    shift || true
    name="${name#nvim-}"   # accept either 'prompt' or 'nvim-prompt'
    local appname="nvim-${name}"
    local wt="${CONFIG_HOME}/${appname}"

    printf 'removing worktree %s\n' "${wt}"
    git -C "${REPO_ROOT}" worktree remove "${wt}" "$@"

    local dir
    for dir in "${DATA_HOME}/${appname}" "${STATE_HOME}/${appname}" "${CACHE_HOME}/${appname}"; do
        if [ -e "${dir}" ]; then
            printf '  rm     %s\n' "${dir}"
            rm -rf "${dir}"
        fi
    done
    printf 'done. git branch left intact (delete manually if desired: git branch -d <branch>)\n'
}

cmd_list() {
    git -C "${REPO_ROOT}" worktree list
}

main() {
    local sub="${1:-}"
    shift || true
    case "${sub}" in
        add)    cmd_add "$@" ;;
        remove) cmd_remove "$@" ;;
        list)   cmd_list "$@" ;;
        -h | --help | help | "") usage 0 ;;
        *) die "unknown subcommand: ${sub} (try: add | remove | list)" ;;
    esac
}

main "$@"
