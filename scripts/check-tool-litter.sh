#!/usr/bin/env bash
set -euo pipefail

# check-tool-litter.sh - Find formatters and linters that write into the working
# directory.
#
# Runnable from anywhere: the script cds into the Neovim config repository root
# (the parent of this script's directory) before scanning, so the
# lua/plugins/**/opts.lua paths resolve regardless of the caller's working
# directory.
#
# It delegates the actual check to check-tool-litter.lua, executed with
# `nvim --headless -l`. The Lua checker resolves the exact argv this config
# would run for every configured formatter and linter, runs each one inside a
# fresh empty directory, and reports anything left behind. Tools are supposed to
# keep caches under XDG_CACHE_HOME or a temp directory; the ones that default to
# the cwd instead are only discoverable by running them and looking.
#
# Usage:
#   scripts/check-tool-litter.sh            # every configured tool
#   scripts/check-tool-litter.sh rumdl ruff # only the named tools
#
# Set CHECK_TOOL_LITTER_VERBOSE=1 to also list which tools were skipped and why.
#
# Exit code: 0 when nothing littered, 1 when any tool did.

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(dirname "${SCRIPT_DIR}")"

cd "${REPO_ROOT}"

exec nvim --headless -l "${SCRIPT_DIR}/check-tool-litter.lua" "$@"
