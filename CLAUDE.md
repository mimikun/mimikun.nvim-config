# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration repository designed for personal use, managing plugins, colorschemes, and language-specific settings using lazy.nvim as the plugin manager.

## Development Commands

### Task Runner (Taskfile)

The repository uses [Task](https://taskfile.dev) as the primary task runner. All common operations are defined in `Taskfile.yml`:

```bash
# List all available tasks
task

# Git operations
task pull                  # Pull from all remotes
task push                  # Push to origin and codeberg remotes
task clean-fetch          # Fetch with prune (also: task cleanfetch)

# Branch management
task switch-master        # Switch to master branch (also: task smas)
task patch-branch         # Create dated patch branch (also: task pab)
task delete-branch        # Delete all patch* branches (also: task deleb)

# Daily workflow
task morning-routine      # Run clean-fetch, delete-branch, pull, and create new patch branch
```

### Plugin Management

This configuration uses lazy.nvim but with a **currently disabled plugin loading system**:

```lua
-- In lua/config/lazy.lua, the spec imports are commented out:
spec = {
  --{ import = "plugins" },
  --{ import = "colorschemes" },
},
```

**Important**: To enable plugins, uncomment these lines in `lua/config/lazy.lua`.

### Neovim Commands

```bash
# Launch Neovim (plugins auto-install via lazy.nvim)
nvim

# Open lazy.nvim UI (after launching Neovim)
:Lazy

# Update plugins
:Lazy update

# Sync plugins (install missing, clean removed)
:Lazy sync
```

## Architecture

### Directory Structure

```
.
├── init.lua                    # Entry point: sets basic options, loads lazy.nvim
├── lua/
│   ├── config/
│   │   └── lazy.lua           # lazy.nvim configuration and setup
│   ├── plugins/               # Plugin specifications (currently not loaded)
│   │   └── plugins-list.md    # Comprehensive list of 330+ plugin names
│   └── colorschemes/          # Colorscheme plugin specifications
│       └── colorschemes-list.md # List of 12 colorscheme plugins
├── after/
│   ├── ftplugin/              # Filetype-specific settings
│   │   ├── rust.lua
│   │   ├── haskell.lua
│   │   ├── java.lua
│   │   └── cabal.lua
│   └── lsp/                   # LSP server configurations (TODOs)
│       ├── yamlls.lua
│       ├── jsonls.lua
│       ├── taplo.lua
│       └── helm_ls.lua
├── snippets/                  # Traditional snippet files
├── luasnippets/              # LuaSnip snippet definitions
├── vscode-snippets/          # VSCode-style snippet definitions
├── templates/                # File templates
└── neovim_tips/              # Personal tips and notes
```

### Configuration Flow

1. **init.lua**: Bootstraps Neovim with basic settings
   - Enables `vim.loader` for faster Lua module loading
   - Sets global options (number, relativenumber, clipboard, etc.)
   - Disables external providers (Perl, Python3, Ruby, Node)
   - Sets leader key to Space, localleader to backslash
   - Loads lazy.nvim via `require("config.lazy")`
   - Includes DVC filetype detection autocmd

2. **lua/config/lazy.lua**: Configures lazy.nvim
   - Auto-installs lazy.nvim on first run
   - Sets lazy-loading defaults (all plugins lazy by default)
   - Defines concurrency based on platform (Windows uses 2x CPU cores)
   - Disables git throttling and cooldown for faster operations
   - Optimizes performance by disabling built-in plugins (gzip, netrw, etc.)
   - **Critical**: Plugin specs currently commented out - must be manually enabled

3. **after/**: Loads after main configuration
   - `ftplugin/`: Language-specific settings (mostly TODOs)
   - `lsp/`: LSP server configurations (mostly TODOs)

### Plugin Organization

- **plugins-list.md**: Contains 330+ plugin names (one per line)
  - Notable categories: LSP tools (Mason, nvim-lspconfig), completions (blink-cmp, nvim-cmp), AI assistants (avante, codecompanion, copilot), Git integration, UI enhancements, language-specific tools

- **colorschemes-list.md**: Contains 12 colorscheme options
  - catppuccin, cyberdream, dracula, github-theme, kanagawa, monokai, nightfox, pastelnight, sonokai, tokyonight

### Key Design Decisions

1. **Lazy Loading**: All plugins are lazy-loaded by default (`lazy = true` in lazy.nvim config)

2. **Multi-Remote Git Setup**: Configured to push to both `origin` and `codeberg` remotes (main branch: `master`)

3. **Daily Workflow Pattern**: Uses dated patch branches (`patch-YYYYMMDD`) for daily development work

4. **Provider Management**: All external language providers disabled to reduce startup time

5. **Modular LSP Config**: LSP configurations separated into individual files in `after/lsp/`

6. **Multi-Format Snippet Support**: Supports traditional, LuaSnip, and VSCode snippet formats

## Current State and TODOs

### Active TODOs

The following files contain TODO markers for incomplete implementations:

- `after/ftplugin/rust.lua`: Needs rust-language-server configs
- `after/lsp/yamlls.lua`: Needs yaml-ls configs
- `after/lsp/jsonls.lua`: Needs JSON language server configs
- `after/lsp/taplo.lua`: Needs TOML language server configs
- `after/lsp/helm_ls.lua`: Needs Helm language server configs
- `Taskfile.yml`: `clean` task is marked as WIP

### Plugin Loading Status

**Critical**: The plugin system is currently disabled. To activate plugins:

1. Edit `lua/config/lazy.lua`
2. Uncomment the spec imports:
   ```lua
   spec = {
     { import = "plugins" },      -- Enable plugin loading
     { import = "colorschemes" },  -- Enable colorscheme loading
   },
   ```
3. Create actual plugin spec files in `lua/plugins/` (currently only has list file)
4. Create colorscheme spec files in `lua/colorschemes/`

## Coding Standards

### Lua Code Style

- **Indentation**: 2 spaces (defined in .editorconfig)
- **Line endings**: LF (Unix-style)
- **Charset**: UTF-8
- **Final newline**: Required

### File Type Conventions

See `.editorconfig` for complete style rules across different file types (shell scripts, YAML, JSON, TOML, TypeScript, Makefiles, PowerShell).

## Notes for Future Development

1. **Plugin Specifications Missing**: The `plugins-list.md` contains plugin names but no actual lazy.nvim spec files exist yet

2. **LSP Configuration Incomplete**: All LSP config files are empty with TODO comments

3. **Branch Strategy**: Uses patch branches for development, master as main branch

4. **Platform Detection**: Configuration includes Windows-specific optimizations (concurrency settings)

5. **Performance Optimization**: Aggressive built-in plugin disabling for faster startup times

