# Product Vision

## Purpose

Personal Neovim configuration focused on modularity, extensibility, and maintainability. Designed for multi-language development with emphasis on lazy-loading performance and plugin ecosystem exploration.

## Core Value Propositions

### For User

- **Zero-startup overhead**: Plugins disabled by default, opt-in activation model
- **Experimentation-friendly**: 330+ curated plugins available as exploration catalog
- **Multi-language support**: Dedicated LSP and filetype configurations for Rust, Haskell, Java, Go, TypeScript, etc.
- **Task-driven workflow**: Automated daily routines (morning-routine: clean fetch → delete branches → pull → new patch branch)

### For Contributors

- **Low entry barrier**: Clear separation between enabled/disabled plugins
- **Documentation-first**: Comprehensive CLAUDE.md with workflow guidance
- **Conventional patterns**: Standard Lua module structure, EditorConfig compliance

## Core Capabilities

### Plugin Management

- **Lazy.nvim foundation**: Modern plugin manager with auto-installation
- **Lazy-by-default**: All plugins configured with `lazy = true`
- **Active plugin specs**: Plugin imports enabled in `lua/config/lazy.lua` (plugins, colorschemes, denops-plugins)
- **Colorscheme catalog**: 12 colorscheme options documented in `lua/colorschemes/colorschemes-list.md`
- **Denops ecosystem**: Dedicated `lua/denops-plugins/` category for Denops-based plugins

### Development Environment

- **LSP-ready**: Pre-configured slots for yamlls, jsonls, taplo, helm_ls
- **Language-specific**: Filetype plugins for Rust, Haskell, Java, Cabal
- **Snippet ecosystem**: Traditional, LuaSnip, and VSCode format support
- **Template system**: File templates for common use cases

### Workflow Automation

- **Task runner**: Taskfile.yml with git operations, branch management, daily routines
- **Multi-remote strategy**: Push to origin + codeberg simultaneously
- **Patch-based development**: Dated branches (patch-YYYYMMDD) for daily work
- **Clean history**: Automated branch cleanup via morning-routine

## Success Metrics

### Performance

- Fast startup time (vim.loader enabled, built-in plugins disabled)
- Lazy plugin loading (no eager activation)

### Maintainability

- Clear module boundaries (after/ftplugin, after/lsp, lua/plugins, lua/colorschemes)
- TODOs tracked in place (rust-analyzer, LSP configs)
- EditorConfig enforcement

### User Experience

- Minimal default configuration (only essential options)
- Progressive disclosure (start minimal, enable features as needed)
- Documentation accessibility (CLAUDE.md, neovim_tips/)

## Active Plugins

Active plugins are cataloged in `lua/plugins/` (one subdirectory per plugin). Run `ls lua/plugins/` for the full list. Categories span UI, LSP, Git, navigation, editing, notes, media, Denops, and tooling integrations.

## Out of Scope

- Pre-configured IDE-like experience (user enables what they need)
- Opinionated keybindings (minimal defaults: Space leader, double-Esc nohlsearch)
- One-size-fits-all plugin selection (catalog approach over defaults)

