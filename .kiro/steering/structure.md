# Project Structure

<!-- updated_at: 2026-07-31 — synced with codebase: init.lua thinned to a loader,
     lua/config/ split into single-responsibility modules, scripts/ + lint tooling added -->

## Directory Organization

```
nvim/
├── init.lua                      # Thin loader: vim.loader + require("config.*") chain
├── filetype.lua                  # Neovim runtime filetype hook (vim.filetype.add)
├── lua/
│   ├── config/                  # One module per concern, all required from init.lua
│   │   ├── host.lua             # Environment detection (single source of truth)
│   │   ├── variables.lua        # vim.g.* — leader, providers, clipboard selection
│   │   ├── options.lua          # Exhaustive vim.opt.* catalog (see tech.md)
│   │   ├── clipboard.lua        # vim.g.clipboard provider tables
│   │   ├── lazy.lua             # Plugin manager configuration (specs active)
│   │   ├── autocmds.lua         # Global autocommands
│   │   ├── mappings.lua         # Global keymaps (minimal)
│   │   ├── usercmds.lua         # User commands
│   │   ├── neovide.lua          # Neovide-only GUI settings
│   │   └── denops.lua           # Returns bool: denops allowlist gate
│   ├── plugins/
│   │   ├── docs/                # Per-plugin research notes (see below)
│   │   ├── <plugin-name>/       # Each plugin in its own subdirectory
│   │   │   ├── init.lua         # Main spec (required)
│   │   │   ├── opts.lua         # Configuration options
│   │   │   ├── cmds.lua         # Command triggers
│   │   │   ├── events.lua       # Event triggers
│   │   │   ├── keys.lua         # Keymaps
│   │   │   ├── ft.lua           # Filetype triggers
│   │   │   ├── dependencies.lua # Plugin dependencies
│   │   │   └── builds.lua       # Build commands
│   │   └── ...
│   ├── colorschemes/
│   │   ├── colorschemes-list.md # Colorscheme catalog (wishlist, not installed set)
│   │   └── <theme-name>/        # Same subdirectory pattern as plugins
│   ├── denops-plugins/          # Denops-based plugins (separate category)
│   │   └── <plugin-name>/       # Same subdirectory pattern
│   └── milli/                   # Plugin-owned data modules (e.g. splash art)
├── after/
│   ├── ftplugin/                # Language-specific settings
│   │   ├── rust.lua             # Rust (TODO: rust-analyzer)
│   │   ├── haskell.lua          # Haskell
│   │   ├── java.lua             # Java
│   │   └── cabal.lua            # Cabal
│   └── lsp/                     # LSP server configs — return vim.lsp.Config
│       ├── yamlls.lua           # YAML (TODO)
│       ├── jsonls.lua           # JSON (TODO)
│       ├── taplo.lua            # TOML (TODO)
│       └── helm_ls.lua          # Helm (TODO)
├── scripts/                     # Headless-Neovim guard scripts + shell wrappers
│   ├── check-keys-spec.{lua,sh}     # Lint lua/**/keys.lua for LazyKeysSpec shape
│   ├── check-options-sync.{lua,sh}  # Detect options.lua vs Neovim option-set drift
│   ├── nvim-plugin-clone.sh         # Vendor a plugin + scaffold its spec
│   └── nvim-worktree.sh             # Parallel config worktrees via NVIM_APPNAME
├── docs/                        # Repo-level design notes and plans/
├── snippets/                    # Traditional snippet format
├── luasnippets/                 # LuaSnip format
├── vscode-snippets/             # VSCode format
├── templates/                   # File templates
├── neovim_tips/                 # Personal notes
├── Taskfile.yml                 # Task automation
├── selene.toml + selene/        # Lua linter config + Neovim std globals
├── .stylua.toml                 # Lua formatter config
├── .editorconfig                # Code style enforcement
└── CLAUDE.md                    # Project documentation (AI guidance)
```

## Module Loading Flow

### Initialization Chain

`init.lua` holds **no configuration of its own** — it enables `vim.loader`, requires
each `config.*` module in a fixed order, then sets the colorscheme. Anything new
belongs in the module that owns that concern, not in `init.lua`.

1. **init.lua** — load order (order matters):
   `config.variables` → `config.options` → `config.lazy` → `config.autocmds`
   → `config.mappings` → `config.usercmds` → `config.neovide` → `vim.cmd.colorscheme`
   - `variables` before `options`: leader keys must exist before mappings are defined
   - `lazy` before `autocmds`/`mappings`: plugin specs may register their own

2. **filetype.lua** (repo root) — sourced by Neovim's own runtime filetype
   mechanism, before `after/ftplugin`. Extension/filename/pattern rules live here;
   pattern rules that must beat a built-in need an explicit `priority`.

3. **lua/config/lazy.lua** — plugin manager setup
   - Auto-install lazy.nvim if missing
   - **Active imports**: `plugins`, `colorschemes`, `denops-plugins`

4. **after/** — post-configuration (loaded after init)
   - `ftplugin/*.lua` - Filetype-specific settings
   - `lsp/*.lua` - LSP server configurations

### config/ Module Boundaries

Each `lua/config/*.lua` owns exactly one concern and is required by name. Two of
them are **libraries rather than steps** — they return a value instead of applying
settings, and are required from wherever they are needed:

- `config.host` → table of environment predicates (`is_windows()`, `is("azusa")`,
  `is_human_rights()`, `paths.*`). Never re-detect host/OS anywhere else.
- `config.clipboard` → named provider tables; `config.variables` picks one.
- `config.denops` → a single boolean, used as `cond`/`enabled` in denops specs.

### Import Patterns

#### Lazy.nvim Spec Import (Active)

```lua
-- lua/config/lazy.lua
spec = {
  { import = "plugins" },
  { import = "colorschemes" },
  { import = "denops-plugins" },
},
```

Imports all `init.lua` files from:
- `lua/plugins/<name>/init.lua` (subdirectory per plugin)
- `lua/colorschemes/<name>/init.lua` (subdirectory per colorscheme)
- `lua/denops-plugins/<name>/init.lua` (subdirectory per Denops plugin)

#### Module Require Pattern

```lua
-- init.lua — every config module is required by dotted path, never by file path
require("config.lazy")  -- Loads lua/config/lazy.lua
```

## File Naming Conventions

### Configuration Files

- `init.lua` - Entry point (Neovim standard)
- `lazy.lua` - Plugin manager config (lowercase, descriptive)
- `*.md` - Documentation (UPPER for root-level, lowercase for subdirs)

### Language-Specific Files

- Pattern: `<filetype>.lua` (e.g., `rust.lua`, `haskell.lua`)
- Location: `after/ftplugin/` (Neovim's filetype plugin directory)
- Auto-loaded: When buffer with matching filetype is opened

### LSP Configuration Files

- Pattern: `<server-name>.lua` (e.g., `yamlls.lua`, `jsonls.lua`)
- Location: `after/lsp/` (custom directory, requires manual loading)
- Currently: Placeholder TODOs

### Plugin Specification Files

- Pattern: Subdirectory named after plugin slug (e.g., `lua/plugins/vim-illuminate/`)
- Entry point: `init.lua` inside each subdirectory (returns `LazySpec` table)
- Optional modules: `opts.lua`, `cmds.lua`, `events.lua`, `keys.lua`, `ft.lua`, `dependencies.lua`, `builds.lua`
- Location: `lua/plugins/`, `lua/colorschemes/`, or `lua/denops-plugins/`
- Denops plugins: Same pattern under `lua/denops-plugins/`

## Code Organization Patterns

### init.lua Structure

```
1. Performance      vim.loader.enable()
2. config.variables vim.g.* — leader, providers, clipboard selection
3. config.options   exhaustive vim.opt.* catalog
4. config.lazy      plugin manager + spec imports
5. config.autocmds  global autocommands
6. config.mappings  global keymaps (Esc-Esc nohlsearch only)
7. config.usercmds  user commands
8. config.neovide   GUI settings, no-ops outside Neovide
9. Colorscheme      vim.cmd.colorscheme("tokyonight")
```

Nothing else lives here. New behaviour goes into the module that owns the concern —
if none fits, add a module and insert it in this list.

### lazy.lua Structure

```
1. require("config.host")
2. Bootstrap (auto-install lazy.nvim)
3. Runtime Path Prepend
4. Local Leader Definition
5. Concurrency (host-derived)
6. lazy.setup() Configuration:
   - root / lockfile / state / pkg.cache / rocks.root / readme.root  (paths)
   - defaults: lazy = true
   - spec: plugins, colorschemes, denops-plugins imports (active)
   - concurrency: host-specific
   - git: throttle disabled, cooldown 0
   - dev: local plugin override path (~/projects)
   - install / ui / diff: fallback colorscheme, Nerd Font icons, diff command
   - performance: disabled built-in plugins
   - checker: auto-update disabled
   - profiling: loader + require enabled
```

**Note**: `maplocalleader` is set here rather than in `variables.lua` — lazy.nvim
requires both leaders to be defined before `setup()` runs.

### after/ Organization

- **ftplugin/**: One file per language (e.g., `rust.lua`)
- **lsp/**: One file per LSP server (e.g., `yamlls.lua`) + optional reference docs (`.md`, `.txt`)
- No subdirectories (flat structure)
- Files loaded automatically by Neovim (`ftplugin`) or manually (`lsp`)

## Import Dependencies

### Critical Path

```
init.lua
  └─> require("config.variables") ──> require("config.clipboard")
  └─> require("config.options")   ──> require("config.host")
  └─> require("config.lazy")      ──> require("config.host")
        └─> imports lua/plugins/<name>/init.lua (active)
        └─> imports lua/colorschemes/<name>/init.lua (active)
        └─> imports lua/denops-plugins/<name>/init.lua (active)
              └─> require("config.denops") as cond/enabled gate
```

`config.host` is the leaf everything else depends on — it must stay free of
requires into the rest of the config.

### Side Loading

```
after/ftplugin/<filetype>.lua  # Auto-loaded by Neovim on filetype detection
after/lsp/<server>.lua          # Manual loading required (no auto-mechanism)
```

## External File References

### Taskfile.yml

- **Purpose**: Git workflow automation
- **Key tasks**: morning-routine, push (dual remote), patch-branch
- **Not imported**: Standalone task runner

### .editorconfig

- **Purpose**: Code style enforcement across editors
- **Scope**: Lua, Shell, YAML, JSON, TOML, TypeScript, Makefiles, PowerShell
- **Not imported**: Editor-level configuration

### CLAUDE.md

- **Purpose**: AI assistant guidance (this file)
- **Audience**: Claude Code and human contributors
- **Not imported**: Documentation reference

## Snippet Directories

- `snippets/` - Traditional format (e.g., UltiSnips, neosnippet)
- `luasnippets/` - LuaSnip native format
- `vscode-snippets/` - VSCode extension format
- **Status**: Directories exist, no plugin integration configured

## Configuration Propagation

### Global Options (init.lua)

```lua
vim.opt.* = value  -- Applies to all buffers
vim.g.* = value    -- Global variables
```

### Buffer-Local Options (ftplugin)

```lua
-- after/ftplugin/rust.lua
vim.bo.tabstop = 4  -- Only for Rust buffers
```

### Filetype Detection (init.lua)

```lua
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Dvcfile", "*.dvc", "dvc.lock" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})
```

## Active Plugins

Active plugins live in `lua/plugins/<name>/` — run `ls lua/plugins/` for the full list (grows unboundedly; not cataloged here). Same pattern applies to `lua/colorschemes/` and `lua/denops-plugins/`.

## Documentation Pattern

Research notes live next to what they describe, one Markdown file per subject:

- `lua/plugins/docs/<Category>/<plugin-name>.md` — per-plugin integration notes:
  options researched, conflicts, usage. Categories are created as needed
  (`Integrations/`, `Motions/`). Replaces the old single `Integrations-memo.md`.
- `docs/<topic>.md` — repo-level design notes that span plugins (e.g. a config
  module's rationale).
- `docs/plans/<topic>.md` — comparison/decision documents written before a change
  (e.g. evaluating competing plugins).

## Quality Tooling

Lint and format config sits at the repo root; the guard scripts run headless Neovim
so they see the real option/spec surface rather than parsing text.

- `.stylua.toml` — formatting (2-space, 120 col, double quotes)
- `selene.toml` + `selene/globals.toml` — Lua lint with a Neovim std definition.
  `shadowing` and `mixed_table` are allowed on purpose: lazy.nvim specs are
  positional-plus-named by design.
- `task check-keys` (`ck`) — rejects nested `opts` tables in `lua/**/keys.lua`
- `task check-options-sync` (`cos`) — flags options added/removed by a Neovim
  upgrade that `lua/config/options.lua` has not caught up with

## Anti-Patterns to Avoid

- **Don't**: Create nested subdirectories in `after/ftplugin/` or `after/lsp/`
- **Don't**: Mix plugin specs with configuration in same file
- **Don't**: Put runtime logic in `lua/plugins/*.lua` (use `config` function)
- **Don't**: Create `plugin/` directory (conflicts with lazy loading)
- **Don't**: Use `require()` for optional modules without pcall
- **Don't**: Add configuration to `init.lua` — it is a loader; put it in the owning
  `lua/config/*.lua` module
- **Don't**: Re-detect hostname / OS / WSL inline — call `config.host`
- **Don't**: Define filetype rules in `autocmds.lua` when `filetype.lua` can express
  them (the runtime hook is faster and beats `after/ftplugin` ordering surprises)

## Maintenance Patterns

### Adding New Language Support

1. Create `after/ftplugin/<lang>.lua` with buffer-local settings
2. Create `after/lsp/<server>.lua` with LSP configuration (if applicable)
3. Update CLAUDE.md with language-specific guidance

### Enabling Plugin

1. `task plugin-setup -- <git-url>` scaffolds the subdirectory and spec skeleton
   (or create `lua/plugins/<name>/init.lua` by hand — imports are already active)
2. Restart Neovim (lazy.nvim auto-installs)
3. To disable a plugin without removing: set `cond = false` or `enabled = false` in spec
4. Run `task check-keys` if the plugin ships a `keys.lua`

### Adding a config Concern

1. Create `lua/config/<concern>.lua`; if it *applies* settings, `require` it from
   `init.lua` at the right point in the order — if it *returns* a value, leave
   `init.lua` alone and require it from consumers
2. Route any environment branch through `config.host` rather than a new detection

### Working on Another Branch in Parallel

Use `scripts/nvim-worktree.sh` (`/nvim-worktree`) rather than switching branches —
each worktree gets `~/.config/nvim-<name>` with its own `NVIM_APPNAME`, so plugin
and data dirs stay isolated.

### Task Automation

1. Add task to `Taskfile.yml` under `tasks:` section
2. Use `task <name>` or `task <alias>` to run
3. Chain tasks with `task: <dependency>`
4. Long logic goes in `scripts/` with a thin `.sh` wrapper the task calls; keep
   Taskfile entries to one line

