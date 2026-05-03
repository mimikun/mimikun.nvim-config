# Technical Architecture

## Technology Stack

### Core Framework

- **Neovim**: Modern Vim with Lua API, LSP, Treesitter
- **Lua 5.1/LuaJIT**: Configuration language (vim.loader enabled for performance)
- **lazy.nvim**: Plugin manager (auto-install from stable branch)

### Configuration Languages

- **Lua**: Primary configuration language (init.lua, module system)
- **YAML**: Task automation (Taskfile.yml)
- **EditorConfig**: Cross-editor style enforcement

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
**Implementation**: `init.lua:26-29` - `vim.g.loaded_*_provider = 0`

### Performance Optimizations

**Decision**: Disable built-in plugins (gzip, netrw, matchparen, etc.)
**Rationale**: Reduce startup overhead, modern alternatives available
**Trade-offs**: Users must install plugin alternatives (e.g., neo-tree for netrw)
**Implementation**: `lua/config/lazy.lua:104-113` - `performance.rtp.disabled_plugins`

### Windows-Specific Concurrency

**Decision**: 2x CPU cores for git operations on Windows
**Rationale**: Mitigate Windows filesystem performance issues
**Trade-offs**: Higher resource usage on Windows
**Implementation**: `lua/config/lazy.lua:30` - conditional concurrency

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

## Testing Strategy

**Current Status**: No automated tests
**Future Consideration**: Integration tests for critical workflows (lazy.nvim bootstrap, plugin loading)

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

- **Task**: Task runner for git operations (Taskfile.yml)
- **Git**: Version control + multi-remote push

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

- Plugin catalog (plugins-list.md) still contains 330+ entries but only a subset have spec files
- LSP servers installable via Mason (mason-nvim added), but LSP configs (after/lsp/*.lua) remain TODO
- Snippets directories exist but no plugin integration configured
- Templates exist but no plugin to use them

