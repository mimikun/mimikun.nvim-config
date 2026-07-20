#!/usr/bin/env bash
set -euo pipefail

# check-options-sync.sh - Detect drift between the running Neovim's option set
# and lua/config/options.lua.
#
# Runnable from anywhere: the script cds into the Neovim config repository root
# (the parent of this script's directory) before scanning, so the
# lua/config/options.lua path resolves regardless of the caller's working
# directory.
#
# It delegates the actual check to check-options-sync.lua, executed with
# `nvim --headless -l`. The Lua checker diffs the authoritative option set from
# `nvim_get_all_options_info()` against the option names mentioned in
# options.lua, reporting MISSING (added upstream) and STALE (removed upstream)
# options. Run it after upgrading Neovim.
#
# Usage:
#   scripts/check-options-sync.sh
#
# Exit code: 0 when in sync, 1 when any MISSING or STALE option is found.

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(dirname "${SCRIPT_DIR}")"

cd "${REPO_ROOT}"

exec nvim --headless -l "${SCRIPT_DIR}/check-options-sync.lua" "$@"
