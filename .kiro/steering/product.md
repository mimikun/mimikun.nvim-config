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

## Active Plugins (Examples)

- **UI**: transparent-nvim, glaze-nvim, smear-cursor-nvim, tiny-glimmer-nvim, drop-nvim, wrapped-nvim, paint-nvim, tiny-cmdline-nvim, edgy-nvim (edge panels), satellite-nvim (scrollbar), statuscol-nvim, virt-column-nvim, ascii-nvim (ASCII art with Telescope, MaximilianLloyd)
- **Focus/Writing**: zen-mode-nvim, twilight-nvim
- **Navigation**: oil-nvim (file manager), lazytree, vim-illuminate
- **File Manager Ecosystem**: oil-nvim, oil-git-nvim, oil-git-status-nvim, oil-lsp-diagnostics-nvim
- **LSP/Diagnostics**: nvim-lspconfig, lazydev-nvim, neoconf-nvim, mason-nvim, tiny-inline-diagnostic-nvim, crates-nvim (Rust crates.io integration, saecki)
- **Syntax**: nvim-treesitter, todo-comments-nvim, ts-comments-nvim
- **Git**: gitsigns-nvim (signcolumn indicators)
- **Keybindings**: which-key-nvim, hardtime-nvim (habit enforcement), surround-ui-nvim (surround text object UI, roobert)
- **Clipboard/Yank**: yanky-nvim, yankbank-nvim, nvim-neoclip-lua, sqlite-lua
- **Session**: persistence-nvim (session management)
- **Tools**: taskfile-nvim, github-actions-nvim, k8s-nvim, chezmoi-nvim/vim, devglobe-extension-nvim, orphans-nvim (plugin cleanup)
- **Time Tracking**: takatime (WakaTime-style), milli-nvim
- **Notes/Markdown**: telekasten-nvim, calendar-vim, md-render-nvim, milli-nvim (MilliPreview)
- **Media**: image-nvim, img-clip-nvim
- **Denops**: denops-vim, denops-translate-vim, denops-docker-vim, dps-ghosttext-vim, dps-translate-vim
- **Diagnostics/Lists**: trouble-nvim (folke, quickfix/diagnostic viewer)
- **Auto-pairs**: blink-pairs (saghen, bracket auto-pairing)
- **Colorschemes**: tokyonight-nvim

## Out of Scope

- Pre-configured IDE-like experience (user enables what they need)
- Opinionated keybindings (minimal defaults: Space leader, double-Esc nohlsearch)
- One-size-fits-all plugin selection (catalog approach over defaults)

