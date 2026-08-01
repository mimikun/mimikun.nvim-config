---
name: add-plugin
description: >
  Add new Neovim plugin(s), colorscheme(s) or denops plugin(s) to this
  lazy.nvim config using scripts/nvim-plugin-clone.sh. By default runs in
  **vendor-only** mode: it vendors the source and spec templates onto an
  add/<plugin> branch and stops, leaving the spec `TODO` markers intact. Pass
  --fill to also complete the lazy.nvim spec, verify it loads, and squash the
  wip commits. Use when the user asks to add or install a Neovim plugin, e.g.
  "/add-plugin https://github.com/author/plugin.nvim".
argument-hint: "[--vendor-only | --fill] [--tree plugins|colorschemes|denops-plugins] <git-url>..."
---

# Add a Neovim Plugin

Add each plugin given in `$ARGUMENTS` using the repository's vendoring script.

By **default** this skill runs in **vendor-only** mode — it vendors the sources
and stops, leaving the scaffolded lazy.nvim spec templates untouched (their
`TODO` markers stay) for the user to complete later by hand. This is a thin
wrapper around `scripts/nvim-plugin-clone.sh`. Pass `--fill` to also complete
the spec, verify it loads, and squash the wip commits into one clean commit.

## Modes

- **vendor-only (default, or `--vendor-only`)** — do steps 1–2 only. Each URL
  gets an `add/<dir-name>` branch with the vendored `CODES/` (and `WIKIS/` if a
  wiki exists) plus spec templates whose `TODO` markers are left untouched
  (marker commit + wip commits, **not** squashed). Then stop and report.
- **`--fill`** — do vendor-only, then steps 3–6: fill in the spec, verify it
  loads, squash the wip commits into one `feat:` commit, and hand off.

## Target trees

The config keeps three parallel plugin trees. Each spec requires its sibling
files under a matching module prefix, so the tree must be decided **before**
running the script — it selects the spec template and the vendoring target.

| Tree | Directory | For |
|---|---|---|
| `plugins` (default) | `lua/plugins/` | ordinary Neovim plugins |
| `colorschemes` | `lua/colorschemes/` | colorschemes |
| `denops-plugins` | `lua/denops-plugins/` | denops (`vim-denops/denops.vim`) plugins |

Throughout the rest of this document `<tree>` means the chosen directory name.

## 1. Parse & validate

- **Mode flag**: scan `$ARGUMENTS` for a mode flag and strip it before treating
  the rest as URLs.
  - `--fill` → fill mode (full workflow, steps 1–6).
  - `--vendor-only`, or no flag → vendor-only mode (steps 1–2). **This is the
    default.**
  - If both flags appear, `--fill` wins.
- **Tree flag**: scan for `--tree <name>` and strip it too. If absent, infer
  the tree from the request and from the plugin itself:
  - the user saying "colorscheme" / "テーマ" / "カラースキーム", or the repo
    being a theme (`CODES/colors/*.vim|lua`, README showing palettes) →
    `colorschemes`
  - the repo depending on `vim-denops/denops.vim` (`CODES/denops/` directory)
    → `denops-plugins`
  - otherwise → `plugins`
  - If the inference is uncertain and the URLs are a mixed batch, ask the user
    which tree each belongs to rather than guessing. **One invocation vendors
    into one tree**; run the skill again for a different tree.
- Each remaining argument must be a git URL. If the user gave a bare
  `author/repo` slug, convert it to `https://github.com/author/repo.git` (the
  script rejects scheme-less values).
- If no URLs remain, ask the user which plugin(s) to add.

## 2. Run the vendoring script

- The script branches off the **current branch**. Check
  `git branch --show-current` first; if it is not `master` (or an up-to-date
  base the user intended), confirm with the user before running.
- Run the task matching the tree — it sets `NVIM_PLUGINS_DIR` for you:
  - `plugins` → `task plugin-setup -- <git-url>...`
  - `colorschemes` → `task colorscheme-setup -- <git-url>...`
  - `denops-plugins` → `task denops-plugin-setup -- <git-url>...`

  Equivalent direct invocation (the bare script defaults to `lua/plugins`):

  ```bash
  NVIM_PLUGINS_DIR=~/.config/nvim/lua/<tree> scripts/nvim-plugin-clone.sh <git-url>...
  ```

- The script prints `INFO: target <dir> -> spec template <name>`. **Check that
  line** — it confirms the tree actually in use before any cloning happens.
- For each URL the script creates a branch `add/<dir-name>`
  (`<dir-name>` = repo name with `.` → `-`, e.g. `convy.nvim` → `convy-nvim`)
  containing:
  - an empty marker commit `feat: add <owner>/<repo>`
  - `lua/<tree>/<dir-name>/CODES/` — the plugin source, history stripped ("wip" commit)
  - `lua/<tree>/<dir-name>/WIKIS/` — the GitHub wiki, if one exists ("wip" commit)
  - spec templates next to `CODES/`: `init.lua`, `cmds.lua`, `events.lua`,
    `keys.lua`, `opts.lua`, `ft.lua`, `dependencies.lua`, plus `stylua.toml`
    and `.editorconfig` ("wip" commit)
  - `init.lua` is the variant for the chosen tree, with its `require()` prefix
    and the repo slug already substituted. The other two init variants are not
    copied — every finished spec has exactly one `init.lua`.
- The script skips URLs whose branch or directory already exists — report any
  `SKIP:` lines to the user.
- Vendored `CODES/`/`WIKIS/` stay in the branch; do not delete them.

**In vendor-only mode (the default), stop here.** Report the created
`add/<dir-name>` branches and any `SKIP:` lines, and note that each spec still
contains `TODO` markers — the user can finish later by editing the spec files
by hand, or by re-running with `--fill`. Do **not** switch branches, edit spec
files, load-test, or squash in this mode. (As always, ask before pushing or
opening PRs.)

**The remaining steps (3–6) run only in `--fill` mode.**

## 3. Fill in the spec (`--fill` mode; repeat per branch)

`git switch add/<dir-name>`, then research the plugin **from the vendored
sources** — `CODES/README.md`, `CODES/doc/*.txt`, `WIKIS/` — to find:

- the Lua module name used in `require("<module>").setup(...)`
  (often differs from the repo name)
- user commands, recommended keymaps, default/example opts,
  dependencies, and relevant filetypes

Then edit the templates in `lua/<tree>/<dir-name>/`, using a finished spec in
the same tree as the reference — `lua/plugins/convy-nvim/` for plugins,
`lua/colorschemes/tokyonight-nvim/` for colorschemes:

- **`init.lua`** — placeholders are already substituted by the script.
  - Uncomment only the lines the plugin needs (`cmd`, `keys`, `event`,
    `ft`, `dependencies`, `opts`/`config`). Leave unused optional lines
    commented, as existing specs do.
  - If the plugin needs `setup()`, use the `config = function()` form:
    `local opts = require("<tree>.<dir-name>.opts")` then
    `require("<module>").setup(opts)`.
  - Change `cond = false` / `enabled = false` to their commented forms
    (`--cond = false` / `--enabled = false`) so the plugin is enabled.
  - **Colorschemes only**: uncomment `lazy = false` and `priority = 1000` so
    the theme loads before everything else, as `tokyonight-nvim` does.
  - Delete the trailing `-- :%s/...` helper comment line.
- **`cmds.lua` / `events.lua` / `keys.lua` / `opts.lua` / `ft.lua` /
  `dependencies.lua`** — replace the `TODO` markers with real values,
  following the shape of existing specs. Before choosing a `<leader>`
  mapping, grep **all three trees** for the same left-hand side and pick a
  non-conflicting one:
  `grep -rn '"<leader>x' lua/plugins lua/colorschemes lua/denops-plugins --include=keys.lua`
- Delete spec files the plugin does not use (e.g. `ft.lua`,
  `dependencies.lua`) and keep their `init.lua` lines commented — merged
  plugins only keep the files they require.

## 4. Verify (`--fill` mode)

- `stylua --check lua/<tree>/<dir-name>/*.lua` — fix any issues
  (do not run stylua over `CODES/`).
- `nvim --headless "+Lazy! install <repo>" "+Lazy! load <repo>" +qa` — must
  load without errors. Debug and fix before reporting done.
- For a colorscheme also confirm it applies:
  `nvim --headless "+colorscheme <name>" +qa`.

## 5. Squash the wip commits (`--fill` mode)

`git rebase -i` is not available here; squash non-interactively into the
empty marker commit (`<base>` is the branch the script ran from, usually
`master`):

```bash
git add -A lua/<tree>/<dir-name>   # stage the spec edits from step 3
marker="$(git log --format='%H %s' <base>..HEAD | grep -m1 'feat: add' | cut -d' ' -f1)"
git reset --soft "${marker}"
git commit --amend -n --no-edit
```

Note: extract the hash with `cut`, never with an awk positional field. This
file is expanded with the invocation arguments before you read it, so a bare
dollar-one inside a snippet is silently replaced by the first URL and the
command becomes syntactically broken. Keep the pipeline `cut`-based.

The branch must end up as a single `feat: add <owner>/<repo>` commit on top
of the base branch. Verify with `git log --oneline master..HEAD`.

## 6. Hand off (`--fill` mode)

- Return to the base branch (`git switch <base>`).
- Report the created branches. Ask the user before pushing or opening PRs
  (`gh pr create` targets `master`).
