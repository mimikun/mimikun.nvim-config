---
name: add-plugin
description: >
  Add new Neovim plugin(s) to this lazy.nvim config using
  scripts/nvim-plugin-clone.sh: the script vendors the plugin source and
  spec templates onto an add/<plugin> branch, then this skill fills in the
  spec files and squashes the wip commits. Use when the user asks to add
  or install a Neovim plugin, e.g. "/add-plugin https://github.com/author/plugin.nvim".
argument-hint: "<git-url>..."
---

# Add a Neovim Plugin

Add each plugin given in `$ARGUMENTS` using the repository's vendoring script,
then complete the lazy.nvim spec it scaffolds.

## 1. Parse & validate

- Each argument must be a git URL. If the user gave a bare `author/repo` slug,
  convert it to `https://github.com/author/repo.git` (the script rejects
  scheme-less values).
- If `$ARGUMENTS` is empty, ask the user which plugin(s) to add.

## 2. Run the vendoring script

- The script branches off the **current branch**. Check
  `git branch --show-current` first; if it is not `master` (or an up-to-date
  base the user intended), confirm with the user before running.
- Run: `scripts/nvim-plugin-clone.sh <git-url>...`
  (equivalent: `task plugin-setup -- <git-url>...`)
- For each URL the script creates a branch `add/<dir-name>`
  (`<dir-name>` = repo name with `.` → `-`, e.g. `convy.nvim` → `convy-nvim`)
  containing:
  - an empty marker commit `feat: add <owner>/<repo>`
  - `lua/plugins/<dir-name>/CODES/` — the plugin source, history stripped ("wip" commit)
  - `lua/plugins/<dir-name>/WIKIS/` — the GitHub wiki, if one exists ("wip" commit)
  - spec templates next to `CODES/`: `init.lua`, `cmds.lua`, `events.lua`,
    `keys.lua`, `opts.lua`, `ft.lua`, `dependencies.lua`, plus `stylua.toml`
    and `.editorconfig` ("wip" commit)
- The script skips URLs whose branch or directory already exists — report any
  `SKIP:` lines to the user.
- Vendored `CODES/`/`WIKIS/` stay in the branch; do not delete them.

## 3. Fill in the spec (repeat per branch)

`git switch add/<dir-name>`, then research the plugin **from the vendored
sources** — `CODES/README.md`, `CODES/doc/*.txt`, `WIKIS/` — to find:

- the Lua module name used in `require("<module>").setup(...)`
  (often differs from the repo name)
- user commands, recommended keymaps, default/example opts,
  dependencies, and relevant filetypes

Then edit the templates in `lua/plugins/<dir-name>/`, using a recently merged
plugin such as `lua/plugins/convy-nvim/` as the finished-state reference:

- **`init.lua`** — placeholders are already substituted by the script.
  - Delete every `denops-plugins.*` require variant (this skill targets
    `lua/plugins/`); if the plugin is actually a denops plugin or a
    colorscheme, stop and ask the user — it belongs elsewhere.
  - Uncomment only the lines the plugin needs (`cmd`, `keys`, `event`,
    `ft`, `dependencies`, `opts`/`config`). Leave unused optional lines
    commented, as existing specs do.
  - If the plugin needs `setup()`, use the `config = function()` form:
    `local opts = require("plugins.<dir-name>.opts")` then
    `require("<module>").setup(opts)`.
  - Change `cond = false` / `enabled = false` to their commented forms
    (`--cond = false` / `--enabled = false`) so the plugin is enabled.
  - Delete the trailing `-- :%s/...` helper comment line.
- **`cmds.lua` / `events.lua` / `keys.lua` / `opts.lua` / `ft.lua` /
  `dependencies.lua`** — replace the `TODO` markers with real values,
  following the shape of existing specs. Before choosing a `<leader>`
  mapping, grep `lua/plugins/*/keys.lua` for the same left-hand side and
  pick a non-conflicting one.
- Delete spec files the plugin does not use (e.g. `ft.lua`,
  `dependencies.lua`) and keep their `init.lua` lines commented — merged
  plugins only keep the files they require.

## 4. Verify

- `stylua --check lua/plugins/<dir-name>/*.lua` — fix any issues
  (do not run stylua over `CODES/`).
- `nvim --headless "+Lazy! install <repo>" "+Lazy! load <repo>" +qa` — must
  load without errors. Debug and fix before reporting done.

## 5. Squash the wip commits

`git rebase -i` is not available here; squash non-interactively into the
empty marker commit (`<base>` is the branch the script ran from, usually
`master`):

```bash
git add -A lua/plugins/<dir-name>   # stage the spec edits from step 3
marker="$(git log --format='%H %s' <base>..HEAD | awk '/feat: add/ {print $1; exit}')"
git reset --soft "${marker}"
git commit --amend -n --no-edit
```

The branch must end up as a single `feat: add <owner>/<repo>` commit on top
of the base branch. Verify with `git log --oneline master..HEAD`.

## 6. Hand off

- Return to the base branch (`git switch <base>`).
- Report the created branches. Ask the user before pushing or opening PRs
  (`gh pr create` targets `master`).
