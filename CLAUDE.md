# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Development Workflow](#development-workflow)
  - [Task Runner (Taskfile)](#task-runner-taskfile)
  - [Git Workflow](#git-workflow)
  - [Plugin Management](#plugin-management)
  - [Neovim Commands](#neovim-commands)
- [Architecture](#architecture)
  - [Directory Structure](#directory-structure)
  - [Configuration Flow](#configuration-flow)
  - [Key Design Decisions](#key-design-decisions)
- [Current Status](#current-status)
  - [Plugin System Status](#plugin-system-status)
  - [Active TODOs](#active-todos)
- [Coding Standards](#coding-standards)
- [AI-DLC Workflow](#ai-dlc-workflow)

## Overview

Personal Neovim configuration repository using lazy.nvim as the plugin manager.

**Key Features:**
- 330+ curated plugins (currently disabled by default)
- 12 colorscheme options
- Modular LSP and filetype configurations
- Multi-format snippet support (traditional, LuaSnip, VSCode)
- Task-based development workflow

## Quick Start

```bash
# 1. Launch Neovim (lazy.nvim auto-installs)
nvim

# 2. Enable plugins (edit lua/config/lazy.lua)
# Uncomment: { import = "plugins" }, { import = "colorschemes" },

# 3. Daily workflow
task morning-routine  # Fetch, clean, pull, create patch branch

# 4. View available tasks
task
```

## Development Workflow

### Task Runner (Taskfile)

All common operations are defined in `Taskfile.yml`:

```bash
# Git operations
task pull           # Pull from all remotes
task push           # Push to origin and codeberg remotes
task clean-fetch    # Fetch with prune (alias: cleanfetch)

# Branch management
task switch-master  # Switch to master branch (alias: smas)
task patch-branch   # Create dated patch branch YYYYMMDD (alias: pab)
task delete-branch  # Delete all patch* branches (alias: deleb)

# Daily workflow
task morning-routine  # Clean fetch → delete branches → pull → new patch branch
```

### Git Workflow

- **Main branch**: `master`
- **Daily development**: Dated patch branches (`patch-YYYYMMDD`)
- **Remotes**: Pushes to both `origin` and `codeberg`

### Plugin Management

**⚠️ IMPORTANT**: Plugin loading is currently **DISABLED** by default.

To enable plugins:

1. Edit `lua/config/lazy.lua`
2. Uncomment the spec imports:
   ```lua
   spec = {
     { import = "plugins" },      -- Enable 330+ plugins
     { import = "colorschemes" },  -- Enable 12 colorschemes
   },
   ```
3. Create plugin spec files in `lua/plugins/` (currently only list exists)
4. Create colorscheme spec files in `lua/colorschemes/`

### Neovim Commands

```vim
:Lazy         " Open plugin manager UI
:Lazy update  " Update all plugins
:Lazy sync    " Install missing, clean removed plugins
```

## Architecture

### Directory Structure

```
.
├── init.lua                      # Entry point: basic options, lazy.nvim loader
├── lua/
│   ├── config/
│   │   └── lazy.lua             # lazy.nvim configuration
│   ├── plugins/                 # Plugin specifications (⚠️ not loaded)
│   │   └── plugins-list.md      # 330+ plugin names
│   └── colorschemes/            # Colorscheme specifications (⚠️ not loaded)
│       └── colorschemes-list.md # 12 colorscheme options
├── after/
│   ├── ftplugin/                # Language-specific settings
│   │   ├── rust.lua             # TODO: rust-analyzer config
│   │   ├── haskell.lua
│   │   ├── java.lua
│   │   └── cabal.lua
│   └── lsp/                     # LSP server configs (⚠️ mostly TODOs)
│       ├── yamlls.lua
│       ├── jsonls.lua
│       ├── taplo.lua
│       └── helm_ls.lua
├── snippets/                    # Traditional snippet format
├── luasnippets/                 # LuaSnip format
├── vscode-snippets/             # VSCode format
├── templates/                   # File templates
└── neovim_tips/                 # Personal notes
```

### Configuration Flow

1. **init.lua** - Bootstrap
   - Enable `vim.loader` for fast Lua module loading
   - Set global options (number, relativenumber, clipboard, etc.)
   - Disable external providers (Perl, Python3, Ruby, Node)
   - Set leader keys (Space = leader, Backslash = localleader)
   - Load lazy.nvim via `require("config.lazy")`
   - DVC filetype detection autocmd

2. **lua/config/lazy.lua** - Plugin Manager
   - Auto-install lazy.nvim on first run
   - Lazy-load all plugins by default
   - Platform-specific concurrency (Windows: 2x CPU cores)
   - Disable git throttling for faster operations
   - Disable built-in plugins (gzip, netrw, etc.) for performance
   - **⚠️ Plugin specs currently commented out**

3. **after/** - Post-configuration
   - `ftplugin/`: Language-specific settings (mostly TODOs)
   - `lsp/`: LSP server configurations (mostly TODOs)

### Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| **Lazy Loading** | All plugins lazy by default (`lazy = true`) |
| **Multi-Remote Git** | Push to `origin` + `codeberg` simultaneously |
| **Patch Branches** | Daily dated branches (`patch-YYYYMMDD`) for development |
| **No External Providers** | Disable Perl/Python/Ruby/Node for faster startup |
| **Modular LSP** | Individual files in `after/lsp/` for maintainability |
| **Multi-Format Snippets** | Support traditional + LuaSnip + VSCode formats |

## Current Status

### Plugin System Status

**🔴 CRITICAL**: The plugin system is currently **DISABLED**.

**Why**: Plugin spec imports are commented out in `lua/config/lazy.lua`

**Impact**:
- No plugins are loaded at startup
- Only base Neovim functionality available
- `lua/plugins/plugins-list.md` contains 330+ plugin names but no specs
- `lua/colorschemes/colorschemes-list.md` lists 12 colorschemes but no specs

**To Enable**:
1. Uncomment specs in `lua/config/lazy.lua`
2. Create actual `.lua` spec files for desired plugins
3. Restart Neovim

### Active TODOs

**LSP Configurations** (all in `after/lsp/`):
- `yamlls.lua` - YAML language server config
- `jsonls.lua` - JSON language server config
- `taplo.lua` - TOML language server config
- `helm_ls.lua` - Helm language server config

**Filetype Configurations**:
- `after/ftplugin/rust.lua` - rust-analyzer settings

**Build Tasks**:
- `Taskfile.yml` - `clean` task marked as WIP

**Plugin Specifications**:
- Create actual plugin spec files (currently only name lists exist)
- Implement lazy.nvim configurations for 330+ plugins
- Create colorscheme spec files for 12 themes

## Coding Standards

### Lua Code Style

```lua
-- Indentation: 2 spaces
-- Line endings: LF (Unix)
-- Charset: UTF-8
-- Final newline: Required
```

See `.editorconfig` for complete style rules across file types (Shell, YAML, JSON, TOML, TypeScript, Makefiles, PowerShell).

## AI-DLC Workflow

**Kiro-style Spec-Driven Development** for AI Development Life Cycle

### Paths

- **Steering**: `.kiro/steering/` - Project-wide rules and context
- **Specs**: `.kiro/specs/` - Feature-specific development processes

### Workflow Phases

**Phase 0 (Optional)**: Setup
```bash
/kiro:steering         # Initialize steering documents
/kiro:steering-custom  # Create custom steering files
```

**Phase 1**: Specification
```bash
/kiro:spec-init "description"       # Initialize new spec
/kiro:spec-requirements {feature}   # Generate requirements
/kiro:validate-gap {feature}        # (Optional) Analyze implementation gap
/kiro:spec-design {feature} [-y]    # Create design (use -y to skip approval)
/kiro:validate-design {feature}     # (Optional) Review design quality
/kiro:spec-tasks {feature} [-y]     # Generate implementation tasks
```

**Phase 2**: Implementation
```bash
/kiro:spec-impl {feature} [tasks]   # Execute tasks with TDD
/kiro:validate-impl {feature}       # (Optional) Validate implementation
```

**Progress Check**:
```bash
/kiro:spec-status {feature}  # Check specification status (use anytime)
```

### Development Rules

1. **3-Phase Approval**: Requirements → Design → Tasks → Implementation
2. **Human Review**: Required after each phase (use `-y` only intentionally)
3. **Language Policy**: Think in English, generate Japanese responses. Project file content (requirements.md, design.md, tasks.md, etc.) follows `spec.json.language` setting
4. **Autonomous Execution**: Follow instructions precisely, gather necessary context, complete work end-to-end, ask only when critical information is missing

### Steering Configuration

**Default Files** (`.kiro/steering/`):
- `product.md` - Product vision and requirements
- `tech.md` - Technical stack and architecture decisions
- `structure.md` - Project structure and organization

**Custom Files**: Managed via `/kiro:steering-custom`

---

**Last Updated**: 2026-01-23

