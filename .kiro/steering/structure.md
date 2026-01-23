# Project Structure

## Directory Organization

```
nvim-new/
├── init.lua                      # Entry point: options, lazy.nvim bootstrap
├── lua/
│   ├── config/
│   │   └── lazy.lua             # Plugin manager configuration
│   ├── plugins/
│   │   └── plugins-list.md      # 330+ plugin catalog (specs TODO)
│   └── colorschemes/
│       └── colorschemes-list.md # 12 colorscheme catalog (specs TODO)
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
   - **⚠️ Plugin specs currently commented out** (lines 25-26)

3. **after/** - Post-configuration (loaded after init)
   - `ftplugin/*.lua` - Filetype-specific settings
   - `lsp/*.lua` - LSP server configurations

### Import Patterns

#### Lazy.nvim Spec Import (Currently Disabled)

```lua
-- lua/config/lazy.lua:24-27
spec = {
  -- { import = "plugins" },      -- ⚠️ Commented out
  -- { import = "colorschemes" }, -- ⚠️ Commented out
},
```

When enabled, imports all files from:
- `lua/plugins/*.lua` (each file returns a plugin spec)
- `lua/colorschemes/*.lua` (each file returns a colorscheme spec)

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

- Pattern: Match plugin name (e.g., `lazy-nvim.lua` for folke/lazy.nvim)
- Location: `lua/plugins/` or `lua/colorschemes/`
- Format: Return table with plugin spec
- Status: **Not yet created** (only list files exist)

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
        └─> (Would import lua/plugins/*.lua if uncommented)
        └─> (Would import lua/colorschemes/*.lua if uncommented)
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

## Future Structure (When Plugins Enabled)

When plugin specs are uncommented:

```
lua/plugins/
  ├── lsp.lua              # LSP-related plugins (nvim-lspconfig, mason)
  ├── treesitter.lua       # Syntax highlighting
  ├── completion.lua       # Completion engines (nvim-cmp, blink-cmp)
  ├── ui.lua               # UI enhancements (lualine, bufferline)
  └── [330+ more specs]

lua/colorschemes/
  ├── tokyonight.lua       # Tokyo Night theme
  ├── catppuccin.lua       # Catppuccin theme
  └── [10+ more specs]
```

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

1. Uncomment spec import in `lua/config/lazy.lua:25-26`
2. Create `lua/plugins/<name>.lua` with spec
3. Restart Neovim (lazy.nvim auto-installs)

### Task Automation

1. Add task to `Taskfile.yml` under `tasks:` section
2. Use `task <name>` or `task <alias>` to run
3. Chain tasks with `task: <dependency>`

