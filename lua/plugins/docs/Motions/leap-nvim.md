# Motion plugins

How the label-jump work is split, and why the keys sit where they do.
Written 2026-07-29; the investigation behind it is in
`docs/plans/motion-plugins.md`.

## Role split

| Role | Owner |
| --- | --- |
| Search-first jump (2 chars, then a label) | leap.nvim |
| Treesitter node selection | leap.nvim |
| Remote operations | leap.nvim |
| Label-first jump (labels on every word start) | mini.jump2d |

Two plugins, not one. leap is search-first: type the target characters,
then pick a label. mini.jump2d is label-first: every candidate is labelled
up front, no search input. Neither replaces the other, so both stay.

flash.nvim covered both, but it reads Neovim's C globals over FFI and
`neovim/neovim#39485` deleted the symbols it depends on, taking every
regex-search path down with them. hop.nvim is unmaintained
(`phaazon/hop.nvim` is a 404, `smoka7/hop.nvim` last moved 2025-08-22).
Both are out.

Do not map `MiniJump2d.builtin_opts.query`. It is a search-first jump
driven by `vim.fn.input`, which duplicates leap and feels nothing like it.

## Keys

Single-key bindings are copied from the upstream leap README, so its
examples (`ygs{leap}$`, `d2gS{leap}`, `yarp{leap}`) work verbatim.

| Key | Mode | Binding |
| --- | --- | --- |
| `s` | n,x,o | `<Plug>(leap)` |
| `gs` | n,o | `<Plug>(leap-remote)` |
| `gS` | n,o | `<Plug>(leap-remote-linewise)` |
| `R` | o | `<Plug>(leap-remote-line)` |
| `ar` | x,o | `<Plug>(leap-remote-text-object)` |
| `ir` | x,o | `<Plug>(leap-remote-inner-text-object)` |
| `an` | x,o | `leap.treesitter.select()` |
| `<leader>lw` | n,x,o | `<Plug>(leap-from-window)` |
| `<leader>la` | n,x,o | `<Plug>(leap-anywhere)` |
| `<leader>lf` | n,x,o | `<Plug>(leap-forward)` |
| `<leader>lb` | n,x,o | `<Plug>(leap-backward)` |
| `<leader>lF` | n,x,o | `<Plug>(leap-forward-next-to)` |
| `<leader>lB` | n,x,o | `<Plug>(leap-backward-next-to)` |
| `<leader>lt` | n,x,o | `<Plug>(leap-next-to)` |

Treesitter selection has no `<Plug>` mapping; `lua/leap/treesitter.lua`
exports `select` only, so `an` calls it through Lua.

## Why these keys and not others

**`gs` is remote, not cross-window.** It used to be
`<Plug>(leap-from-window)`, because the README's suggested `S` was already
taken. But the README also assigns `gs` to `<Plug>(leap-remote)`, and its
usage examples are written in terms of that. Remote won the key; cross-window
moved to `<leader>lw`.

**`S` is unavailable in both relevant modes.** surround-ui.nvim owns it in
normal mode (`root_key = "S"`) and nvim-surround owns it in visual mode
(`<Plug>(nvim-surround-visual)`).

**`gS` is safe despite nvim-surround.** nvim-surround maps `gS` in visual
mode only. leap claims normal and operator-pending. Verified with `maparg`:
`x gS` resolves to `<Plug>(nvim-surround-visual-line)`, `n gS` and `o gS` to
`<Plug>(leap-remote-linewise)`.

**`x` is deliberately unmapped.** `:h leap-mappings` suggests `x` for
`<Plug>(leap-next-to)` in x,o. That would shadow the visual-mode delete.
`<leader>lt` carries it instead.

**`ar` / `ir` / `an` follow an existing pattern.** gitsigns already defines
`ih` and yanky defines `iy` in the same modes, so custom `a`/`i` text
objects are established here.

**`R` in operator-pending only.** The only other `R` in this config is
triptych's `rename_from_scratch`, which is buffer-local to its own window.
(oil-git-status's `["R"] = "R"` looks like a mapping but is a git status
symbol, alongside `A` / `C` / `D` / `M` / `T` / `U`.)

## Gaps left by dropping flash.nvim

leap has no equivalent for two things flash offered:

- `flash.toggle()`, which put labels on `/` search results. `doc/leap.txt`
  has no `incsearch` or `cmdline` handling at all.
- `flash.treesitter_search()`, search-driven node selection.

Both ran through flash's broken regex-search path, so nothing that worked
was lost. Recorded here so the gap is not rediscovered as a regression.

## mini.jump2d

| Key | Mode | Binding |
| --- | --- | --- |
| `<leader>jj` | n,x,o | `builtin_opts.word_start` |
| `<leader>jl` | n,x,o | `builtin_opts.line_start` |
| `<leader>jc` | n,x,o | `builtin_opts.single_character` |

`builtin_opts.query` stays unbound: it is a search-first jump driven by
`vim.fn.input`, which duplicates leap's `s` and feels nothing like it.

All three are bound up front rather than added when a need appears. Deferred
config changes do not survive the gap between deciding and doing; an unused
binding costs one line to delete, so binding now is the cheaper error.

`<leader>j`, not `<leader>l`: leap took the whole `<leader>l` namespace, and
mixing the two plugins under one prefix is what made the old flash bindings
hard to reason about. which-key labels both prefixes (see
`lua/plugins/which-key-nvim/opts.lua`, `spec`) so neither has to be recalled
from memory.

The binding uses the `<Cmd>...<CR>` string form rather than a Lua function.
Upstream does the same for operator-pending mode, where a plain function
breaks dot-repeat (`neovim/neovim#23406`).

`mappings.start_jumping` is set to the empty string, so the plugin installs
no `<CR>` mapping of its own. Its default `<CR>` restores itself
buffer-locally for `qf` buffers and the command-line window, but not for
help or man, where `<CR>` is the built-in tag jump — that gap is the reason
this config binds a `<leader>` key instead.

One lazy.nvim detail worth keeping in mind if the plugin is ever disabled
again: `cond = false` keeps it on disk, `enabled = false` alone does not.
lazy resolves `cond` before `enabled` (`lua/lazy/core/meta.lua:352` then
`:355`), and the `cond` pass registers the plugin in
`spec.ignore_installed`, which excludes it from `Config.to_clean`.
