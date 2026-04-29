# Project Structure

## Directory Organization

```
nvim-new/
├── init.lua                      # Entry point: options, lazy.nvim bootstrap
├── lua/
│   ├── config/
│   │   └── lazy.lua             # Plugin manager configuration (specs active)
│   ├── plugins/
│   │   ├── Integrations-memo.md # Integration notes and research
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
│   │   ├── colorschemes-list.md # 12 colorscheme catalog
│   │   └── <theme-name>/        # Same subdirectory pattern as plugins
│   └── denops-plugins/          # Denops-based plugins (separate category)
│       └── <plugin-name>/       # Same subdirectory pattern
├── after/
│   ├── ftplugin/                # Language-specific settings
│   │   ├── rust.lua             # Rust (TODO: rust-analyzer)
│   │   ├── haskell.lua          # Haskell
│   │   ├── java.lua             # Java
│   │   └── cabal.lua            # Cabal
│   └── lsp/                     # LSP server configurations
│       ├── yamlls.lua           # YAML (TODO)
│       ├── jsonls.lua           # JSON (TODO)
│       ├── taplo.lua            # TOML (TODO)
│       └── helm_ls.lua          # Helm (TODO)
├── snippets/                    # Traditional snippet format
├── luasnippets/                 # LuaSnip format
├── vscode-snippets/             # VSCode format
├── templates/                   # File templates
├── neovim_tips/                 # Personal notes
├── Taskfile.yml                 # Task automation
├── .editorconfig                # Code style enforcement
└── CLAUDE.md                    # Project documentation (AI guidance)
```

## Module Loading Flow

### Initialization Chain
1. **init.lua** - Bootstrap environment
   - Enable `vim.loader` (Lua module cache)
   - Set global options (UI, encoding, providers)
   - Define leader keys
   - Load `require("config.lazy")` (line 33)
   - Register DVC filetype detection

2. **lua/config/lazy.lua** - Plugin manager setup
   - Auto-install lazy.nvim if missing (lines 1-14)
   - Configure lazy.nvim with defaults
   - **Active imports**: `plugins`, `colorschemes`, `denops-plugins` (line 25-27)

3. **after/** - Post-configuration (loaded after init)
   - `ftplugin/*.lua` - Filetype-specific settings
   - `lsp/*.lua` - LSP server configurations

### Import Patterns

#### Lazy.nvim Spec Import (Active)

```lua
-- lua/config/lazy.lua:24-28
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
-- init.lua:33
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
1. Performance (vim.loader)
2. UI Options (termguicolors, mouse, number)
3. File Handling (fileformats, fileencodings)
4. Provider Disablement (Perl, Python, Ruby, Node)
5. User Options (clipboard, leader keys)
6. Plugin Manager (require config.lazy)
7. Colorscheme (commented out)
8. Keymaps (minimal: Esc-Esc nohlsearch)
9. Filetype Detection (DVC autocmd)
```

### lazy.lua Structure

```
1. Bootstrap (auto-install lazy.nvim)
2. Runtime Path Prepend
3. Local Leader Definition
4. lazy.setup() Configuration:
   - root: Plugin installation directory
   - defaults: lazy = true
   - spec: Plugin/colorscheme imports (disabled)
   - lockfile: Version pinning
   - concurrency: Platform-specific
   - git: Throttle and cooldown settings
   - performance: Disabled plugins
   - ui: Nerd Font icons
   - checker: Auto-update disabled
```

### after/ Organization

- **ftplugin/**: One file per language (e.g., `rust.lua`)
- **lsp/**: One file per LSP server (e.g., `yamlls.lua`)
- No subdirectories (flat structure)
- Files loaded automatically by Neovim (`ftplugin`) or manually (`lsp`)

## Import Dependencies

### Critical Path

```
init.lua
  └─> require("config.lazy")
        └─> imports lua/plugins/<name>/init.lua (active)
        └─> imports lua/colorschemes/<name>/init.lua (active)
        └─> imports lua/denops-plugins/<name>/init.lua (active)
```

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

## Current Active Plugin Structure

```
lua/plugins/
  ├── vim-illuminate/              # Symbol highlighting
  ├── telekasten-nvim/             # Zettelkasten notes
  ├── image-nvim/                  # Image preview
  ├── img-clip-nvim/               # Image clipboard paste
  ├── chezmoi-nvim/                # Dotfiles management (chezmoi)
  ├── chezmoi-vim/                 # Dotfiles management (vim)
  ├── taskfile-nvim/               # Taskfile integration
  ├── github-actions-nvim/         # GitHub Actions
  ├── k8s-nvim/                    # Kubernetes
  ├── lazytree/                    # File tree (legacy)
  ├── oil-nvim/                    # File manager (stevearc, replaces netrw)
  ├── oil-git-nvim/                # Git status in oil.nvim (malewicz1337)
  ├── oil-git-status-nvim/         # Git status columns for oil (refractalize)
  ├── oil-lsp-diagnostics-nvim/    # LSP diagnostics in oil (JezerM)
  ├── nvim-lspconfig/              # LSP configuration
  ├── calendar-vim/                # Calendar
  ├── devglobe-extension-nvim/     # Dev globe extension
  ├── transparent-nvim/            # Background transparency
  ├── glaze-nvim/                  # Window glazing effect
  ├── wrapped-nvim/                # Wrap display
  ├── smear-cursor-nvim/           # Cursor smear animation
  ├── tiny-glimmer-nvim/           # Glimmer effect
  ├── drop-nvim/                   # Drop animation (folke)
  ├── ascii-nvim/                  # ASCII art library with Telescope extension (MaximilianLloyd)
  ├── edgy-nvim/                   # Window layout / edge panels (folke)
  ├── styler-nvim/                 # Per-window colorscheme (disabled)
  ├── which-key-nvim/              # Keybinding hints (folke)
  ├── surround-ui-nvim/            # UI for surround text objects (roobert)
  ├── zen-mode-nvim/               # Focus mode (folke)
  ├── lazydev-nvim/                # Neovim Lua dev (folke)
  ├── neoconf-nvim/                # Project config (folke)
  ├── persistence-nvim/            # Session persistence (folke)
  ├── twilight-nvim/               # Dim inactive code (folke)
  ├── nvim-treesitter/             # Syntax highlighting (FileType autocmd)
  ├── paint-nvim/                  # Highlight virtual text (folke)
  ├── todo-comments-nvim/          # TODO comment highlighting (folke)
  ├── ts-comments-nvim/            # TypeScript comment handling (folke)
  ├── mason-nvim/                  # LSP/tool installer (mason-org)
  ├── crates-nvim/                 # Rust crates.io integration (saecki)
  ├── tiny-cmdline-nvim/           # Centered cmdline popup (rachartier)
  ├── tiny-inline-diagnostic-nvim/ # Inline LSP diagnostics (rachartier)
  ├── hardtime-nvim/               # Vim habit enforcement (m4xshen)
  ├── yanky-nvim/                  # Yank history and cycling (gbprod)
  ├── yankbank-nvim/               # Yank bank UI (ptdewey)
  ├── nvim-neoclip-lua/            # Clipboard manager with telescope (AckslD)
  ├── sqlite-lua/                  # SQLite dependency for neoclip/yankbank
  ├── gitsigns-nvim/               # Git signs in signcolumn (lewis6991)
  ├── satellite-nvim/              # Scrollbar with decorations (lewis6991)
  ├── statuscol-nvim/              # Status column customization (luukvbaal)
  ├── virt-column-nvim/            # Virtual colorcolumn (luukvbaal)
  ├── md-render-nvim/              # Markdown rendering (delphinus)
  ├── milli-nvim/                  # Markdown preview / MilliPreview (amansingh-afk)
  ├── orphans-nvim/                # Orphan plugin cleanup (ZWindL)
  ├── takatime/                    # WakaTime-style time tracking (Rtarun3606k)
  ├── trouble-nvim/                # Diagnostics/quickfix viewer (folke)
  ├── blink-pairs/                 # Auto-pair brackets (saghen)
  └── docs/                        # Integration documentation (per-plugin .md files)
      └── Integrations/            # Per-plugin integration notes

lua/colorschemes/
  └── tokyonight-nvim/     # Tokyo Night theme

lua/denops-plugins/
  ├── denops-vim/          # Denops runtime
  ├── denops-translate-vim/ # Translation
  ├── denops-docker-vim/   # Docker
  ├── dps-ghosttext-vim/   # GhostText
  └── dps-translate-vim/   # Translation (dps)
```

## Documentation Pattern

Integration notes and research for each plugin are kept in `lua/plugins/docs/Integrations/<plugin-name>.md`. These are per-plugin Markdown files that document integration considerations, configuration options researched, and usage notes. This replaces the previous single `Integrations-memo.md` file.

## Anti-Patterns to Avoid

- **Don't**: Create nested subdirectories in `after/ftplugin/` or `after/lsp/`
- **Don't**: Mix plugin specs with configuration in same file
- **Don't**: Put runtime logic in `lua/plugins/*.lua` (use `config` function)
- **Don't**: Create `plugin/` directory (conflicts with lazy loading)
- **Don't**: Use `require()` for optional modules without pcall

## Maintenance Patterns

### Adding New Language Support

1. Create `after/ftplugin/<lang>.lua` with buffer-local settings
2. Create `after/lsp/<server>.lua` with LSP configuration (if applicable)
3. Update CLAUDE.md with language-specific guidance

### Enabling Plugin

1. Create `lua/plugins/<name>/init.lua` with LazySpec (imports already active)
2. Restart Neovim (lazy.nvim auto-installs)
3. To disable a plugin without removing: set `--cond = false` or `--enabled = false` in spec

### Task Automation

1. Add task to `Taskfile.yml` under `tasks:` section
2. Use `task <name>` or `task <alias>` to run
3. Chain tasks with `task: <dependency>`

