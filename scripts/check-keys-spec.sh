#!/usr/bin/env bash
set -euo pipefail

# check-keys-spec.sh - Lint lua/**/keys.lua for LazyKeysSpec violations.
#
# Runnable from anywhere: the script cds into the Neovim config repository
# root (the parent of this script's directory) before scanning, so the
# lua/**/keys.lua glob resolves regardless of the caller's working directory.
#
# It delegates the actual check to check-keys-spec.lua, executed with
# `nvim --headless -l`. The Lua checker flags any keymap entry that nests
# desc/silent/noremap/... inside an extra positional table literal, which
# lazy.nvim's LazyKeysSpec silently ignores.
#
# Usage:
#   scripts/check-keys-spec.sh
#   task check-keys
#
# Exit code: 0 when clean, 1 when any violation is found.

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(dirname "${SCRIPT_DIR}")"

cd "${REPO_ROOT}"

exec nvim --headless -l "${SCRIPT_DIR}/check-keys-spec.lua" "$@"
