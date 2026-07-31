# Technical Architecture

<!-- updated_at: 2026-07-31 — synced: host.lua single-source-of-truth, exhaustive
     options.lua, clipboard/denops gating, lint + drift-guard tooling -->

## Technology Stack

### Core Framework

- **Neovim**: Modern Vim with Lua API, LSP, Treesitter
- **Lua 5.1/LuaJIT**: Configuration language (vim.loader enabled for performance)
- **lazy.nvim**: Plugin manager (auto-install from stable branch)

### Configuration Languages

- **Lua**: Primary configuration language (init.lua, module system)
- **YAML**: Task automation (Taskfile.yml)
- **EditorConfig**: Cross-editor style enforcement
- **TOML**: Tooling config (selene.toml, .stylua.toml)

### Quality Tooling

- **StyLua**: Formatter — 2 spaces, 120 columns, double quotes, no statement collapse
- **Selene**: Lua linter with a project-local `selene/globals.toml` std for Neovim.
  `shadowing` and `mixed_table` deliberately allowed (lazy.nvim specs are mixed by design)
- **Headless-Neovim guard scripts** (`scripts/*.lua`, run via `task`): correctness
  checks that need the real Neovim runtime rather than static parsing
- **Neowright**: drives a real Neovim instance for UI/plugin debugging
  (`.neowright/` sessions and snapshots, gitignored)

## Architecture Decisions

### Lazy Loading Strategy

**Decision**: All plugins configured with `lazy = true` by default
**Rationale**: Fast startup time, opt-in activation model
**Trade-offs**: User must explicitly configure plugin loading triggers
**Implementation**: `lua/config/lazy.lua:22` - `defaults = { lazy = true }`

### Plugin Opt-In Model

**Decision**: Plugin specs are active in lazy.lua (uncommented)
**Rationale**: Plugin ecosystem is actively being built out
**Trade-offs**: Startup time increases as more plugins are added
**Categories**: `plugins`, `colorschemes`, `denops-plugins` (each a separate import)
**Migration Note**: Moved from catalog-only to active spec creation

### Multi-Remote Git Strategy

**Decision**: Push to both origin and codeberg simultaneously
**Rationale**: Redundancy, cross-platform availability
**Trade-offs**: Slightly slower push operations
**Implementation**: `Taskfile.yml:32-35` - dual push commands

### Module Organization

**Decision**: Separate directories for ftplugin, lsp, plugins, colorschemes
**Rationale**: Neovim's `after/` convention + lazy.nvim's spec structure
**Trade-offs**: More directory traversal, clearer boundaries
**Pattern**: `after/` for language-specific, `lua/` for plugin specs

### Provider Disablement

**Decision**: Disable Perl, Python3, Ruby, Node providers
**Rationale**: Faster startup, reduce external dependencies
**Trade-offs**: Plugins requiring these providers won't work
**Implementation**: `lua/config/variables.lua` - `vim.g.loaded_*_provider = 0`

### Performance Optimizations

**Decision**: Disable built-in plugins (gzip, netrw, matchparen, etc.)
**Rationale**: Reduce startup overhead, modern alternatives available
**Trade-offs**: Users must install plugin alternatives (e.g., neo-tree for netrw)
**Implementation**: `lua/config/lazy.lua` - `performance.rtp.disabled_plugins`

### init.lua as a Pure Loader

**Decision**: `init.lua` contains no settings — only `vim.loader`, an ordered chain of
`require("config.*")`, and the colorscheme call
**Rationale**: A single growing entry point was the original failure mode; one module
per concern makes each independently reviewable and greppable
**Trade-offs**: Load order becomes load-bearing and implicit (see structure.md)
**Implementation**: `init.lua`

### Environment Detection in One Module

**Decision**: All host / OS / WSL / hardware branching goes through `config.host`,
which resolves and caches everything at load time
**Rationale**: Detection was previously duplicated inline and drifted between call
sites; predicates like `host.is("azusa")` read as intent, `jit.os:find(...)` does not
**Trade-offs**: Values are constant for the session — anything that can change at
runtime does not belong here
**Implementation**: `lua/config/host.lua`; also carries `config_version` and
`paths.*` (stdpath-derived absolute paths)

### Capability Gating over Host Allowlists

**Decision**: Gate features on the capability actually required, not on a machine name
**Rationale**: Hostname allowlists break silently on every new machine
**Examples**:

- Clipboard: selected from `$WAYLAND_DISPLAY` + `executable("wl-copy")`, not hostname.
  Forcing `wl-clipboard` where no Wayland server exists blocks startup on `wl-copy`'s
  daemon (`lua/config/variables.lua` + `lua/config/clipboard.lua`)
- Heavy plugin set: `host.is_human_rights()` compares total RAM against an OS-specific
  threshold
**Exception**: `config.denops` is an explicit `{ os, host }` allowlist — Deno is an
external runtime whose presence cannot be probed cheaply at startup

### Concurrency Tuning

**Decision**: `concurrency = 4` on host `azusa`; 2× parallelism on Windows; default elsewhere
**Rationale**: Windows filesystem overhead; `azusa` is resource-constrained
**Implementation**: `lua/config/lazy.lua` via `host.is_azusa()`

### Filetype Rules in the Runtime Hook

**Decision**: Prefer root `filetype.lua` (`vim.filetype.add`) over `BufRead` autocmds
**Rationale**: Runs in Neovim's own filetype resolution, so it is faster and ordering
against built-ins is explicit via `priority`
**Trade-offs**: Beating a built-in pattern requires knowing to set `priority`
**Implementation**: `filetype.lua` — e.g. `%.?env%..*` → `dotenv` at priority 10, which
outranks Neovim's built-in `.env.*` → `env`
**Note**: `lua/config/autocmds.lua` still holds the DVC → yaml rule

### Git Throttling Disabled

**Decision**: Disable lazy.nvim's git rate limiting
**Rationale**: Local development, no GitHub API rate concerns
**Trade-offs**: Potential network saturation on slow connections
**Implementation**: `lua/config/lazy.lua:34` - `git.throttle.enabled = false`

## Code Conventions

### Lua Style

- **Indentation**: 2 spaces (EditorConfig enforced)
- **Line endings**: LF (Unix)
- **Charset**: UTF-8
- **Module pattern**: `require("module.path")` in init.lua
- **Global options**: `vim.opt.*` (modern API)
- **Legacy options**: Avoided unless necessary

### File Naming

- **Lua modules**: lowercase with hyphens (e.g., `lazy.lua`)
- **Plugin specs**: Match plugin name (e.g., `lazy-nvim.lua`)
- **Language configs**: Filetype name (e.g., `rust.lua`, `haskell.lua`)
- **LSP configs**: Server name (e.g., `yamlls.lua`, `jsonls.lua`)

### Configuration Patterns

#### Basic Options (init.lua)

```lua
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
```

#### Leader Keys

```lua
vim.g.mapleader = " "          -- Space
vim.g.maplocalleader = "\\"    -- Backslash
```

#### Filetype Detection (Autocmd)

```lua
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Pattern" },
  callback = function()
    vim.bo.filetype = "type"
  end,
})
```

#### Lazy Plugin Spec (Subdirectory Pattern)

Each plugin lives in its own subdirectory with separate modules:

```lua
-- lua/plugins/plugin-name/init.lua
---@type LazySpec
local spec = {
  "author/plugin-name",
  cmd = require("plugins.plugin-name.cmds"),
  keys = require("plugins.plugin-name.keys"),
  event = require("plugins.plugin-name.events"),
  config = function()
    require("plugin").setup(require("plugins.plugin-name.opts"))
  end,
  --cond = false,
  --enabled = false,
}
return spec
```

Optional module files per plugin:
- `init.lua` - Main spec (required)
- `opts.lua` - Plugin configuration options
- `cmds.lua` - Command triggers
- `events.lua` - Event triggers
- `keys.lua` - Keymaps
- `ft.lua` - Filetype triggers
- `dependencies.lua` - Plugin dependencies
- `builds.lua` - Build commands

#### GitLab Plugin Spec (url = pattern)

Plugins hosted on GitLab (not GitHub) require `url =` instead of the short `"author/repo"` form:

```lua
local spec = {
  url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  -- rest of spec...
}
```

**Example**: `lua/plugins/rainbow-delimiters-nvim/init.lua`

#### Denops Plugin Spec (Subdirectory Pattern)

Denops-based plugins follow the same subdirectory pattern under `lua/denops-plugins/`.

### Exhaustive, Self-Documenting options.lua

**Decision**: `lua/config/options.lua` lists **every** Neovim option — set to its
default, set to an override, or left commented out when it has no meaningful or
portable default — each with a one-line comment
**Rationale**: The file doubles as reference documentation; "not present" and
"deliberately left alone" become distinguishable states
**Trade-offs**: ~1200 lines, and a Neovim upgrade that adds or removes options
silently makes it wrong — which is exactly what `task check-options-sync` guards
**Implementation**: `lua/config/options.lua`, `scripts/check-options-sync.lua`

## Testing Strategy

**Current Status**: No unit/integration test suite. Correctness is enforced by
headless-Neovim drift guards rather than assertions:

- `task check-keys` (`ck`) — `scripts/check-keys-spec.lua` walks `lua/**/keys.lua`
  and rejects entries that nest options in a sub-table instead of naming them at the
  top level. A `LazyKeysSpec` is `{ lhs, rhs?, desc = ..., silent = ... }`; the nested
  form is accepted silently by Lua and then ignored by lazy.nvim
- `task check-options-sync` (`cos`) — `scripts/check-options-sync.lua` diffs the
  running Neovim's option set against `lua/config/options.lua`

**Pattern**: when a class of mistake is silent at runtime, add a script under
`scripts/` plus a `Taskfile.yml` entry rather than relying on review.

**Future Consideration**: Integration tests for critical workflows (lazy.nvim
bootstrap, plugin loading); Neowright already provides the harness.

## Dependency Management

### Internal Dependencies

- `init.lua` → `lua/config/lazy.lua` (bootstrap)
- `lua/config/lazy.lua` → `lua/plugins/<name>/init.lua` (active via `{ import = "plugins" }`)
- `lua/config/lazy.lua` → `lua/colorschemes/<name>/init.lua` (active via `{ import = "colorschemes" }`)
- `lua/config/lazy.lua` → `lua/denops-plugins/<name>/init.lua` (active via `{ import = "denops-plugins" }`)

### External Dependencies

- **lazy.nvim**: Auto-installed from GitHub (stable branch)
- **Plugins**: Managed by lazy.nvim (all spec files in subdirectories are active)
- **Nerd Fonts**: Required for icons in plugin UI

### Build Tools

- **Task**: Task runner — git operations, plugin vendoring, drift guards (Taskfile.yml)
- **Git**: Version control + multi-remote push (+ worktrees for parallel branches)
- **Deno**: Required only by `lua/denops-plugins/*`, which are gated off by default

## Security Considerations

- No API keys or secrets in configuration
- All plugins loaded from public GitHub repositories (lazy.nvim managed)
- No eval of untrusted code (all Lua modules auditable)

## Platform Support

- **Primary**: Linux (WSL2 assumed from git config)
- **Windows**: Conditional concurrency settings
- **macOS**: Standard Unix settings apply

## Performance Characteristics

- **Startup Time**: Optimized via vim.loader, disabled providers, lazy plugins
- **Runtime**: Lazy-loaded plugins only activated on trigger
- **Git Operations**: Disabled throttling for faster updates

## Known Limitations

- `after/lsp/*.lua` are all still empty `vim.lsp.Config` stubs marked TODO
  (yamlls, jsonls, taplo, helm_ls); `after/ftplugin/rust.lua` likewise
- `lua/colorschemes/colorschemes-list.md` is a **wishlist**, not the installed set —
  only the schemes with a subdirectory are actually vendored
- Snippets directories (`snippets/`, `luasnippets/`, `vscode-snippets/`) and
  `templates/` exist but have no plugin wired to consume them
- `host.paths.*` is populated but has no consumers yet (noted in the source)
- No CI: lint, format, and drift guards run locally only

