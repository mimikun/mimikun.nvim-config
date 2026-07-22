---
name: nvim-worktree
description: >
  Create, list, and remove parallel Neovim-config git worktrees isolated by
  NVIM_APPNAME, using scripts/nvim-worktree.sh. Each worktree lives at
  ~/.config/nvim-<name> (a sibling of the main config) and gets its own
  plugin/data dirs (lazy + treesitter copied, mason symlink-shared) plus a
  direnv .envrc so `cd`-ing in auto-activates NVIM_APPNAME. Use when the user
  wants to work on another branch of this config in parallel without switching
  branches, e.g. "/nvim-worktree add add/prompt-nvim".
argument-hint: "add <branch> [name] | remove <name> [--force] | list"
---

# Manage NVIM_APPNAME-isolated worktrees

Thin wrapper around `scripts/nvim-worktree.sh`. Run the script; it does the
git, data-seeding, and direnv wiring. Do not re-implement its steps by hand.

## Why this exists

Neovim reads `~/.config/nvim` by default, so a worktree checked out elsewhere is
**not** picked up automatically. `NVIM_APPNAME=nvim-<name>` makes Neovim read
`~/.config/nvim-<name>` instead — and because this config is fully
`vim.fn.stdpath()`-based (`lua/config/lazy.lua`), plugins/data/state isolate
cleanly too. Placing the worktree at `~/.config/nvim-<name>` satisfies both the
git-worktree sibling-directory convention and Neovim's `~/.config/nvim-*`
convention at once.

## Commands

Parse `$ARGUMENTS` for the subcommand and pass it straight through.

- **add `<branch> [name]`** — create a worktree for `<branch>` at
  `~/.config/nvim-<name>`. If `name` is omitted it is derived from the branch
  (`add/prompt-nvim` → `prompt`). The script also:
  - seeds `~/.local/share/nvim-<name>` by copying `lazy/` + `site/` and
    symlinking `mason/` from the main data dir (so first launch does **not**
    re-download every plugin / LSP server / parser);
  - writes `.envrc` (`export NVIM_APPNAME=nvim-<name>`), adds `.envrc` to
    `.git/info/exclude`, and runs `direnv allow`.

  ```bash
  scripts/nvim-worktree.sh add add/prompt-nvim
  ```

- **remove `<name> [--force]`** — `git worktree remove` the worktree and delete
  its `~/.local/{share,state,cache}/nvim-<name>` dirs. Accepts `prompt` or
  `nvim-prompt`. **Never deletes the git branch** (merging to master is a manual
  decision); tell the user to `git branch -d <branch>` themselves if they want.

  ```bash
  scripts/nvim-worktree.sh remove prompt
  ```

- **list** — show `git worktree list`.

  ```bash
  scripts/nvim-worktree.sh list
  ```

## After adding

Report to the user how to launch it:

- with direnv active: `cd ~/.config/nvim-<name>` then just `nvim`;
- otherwise: `NVIM_APPNAME=nvim-<name> nvim`.

## Caveats to surface when relevant

- `mason/` is symlink-shared, so `:Mason` **uninstall** inside a worktree
  affects the shared store (install/update is fine — shared cache).
- To vendor a plugin from inside a worktree via `/add-plugin`, set
  `NVIM_PLUGINS_DIR=~/.config/nvim-<name>/lua/plugins` (the clone script
  otherwise hardcodes the main config path).
- `lazy-lock.json` is gitignored, so a fresh worktree has none; plugins resolve
  to latest. Copy the main lockfile and `:Lazy restore` only if version parity
  matters.
