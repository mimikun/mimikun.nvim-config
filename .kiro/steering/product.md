# Product Vision

<!-- updated_at: 2026-07-31 — synced: catalog-era claims replaced with the current
     active-plugin model; options philosophy corrected -->

## Purpose

Personal Neovim configuration focused on modularity, extensibility, and maintainability. Designed for multi-language development with emphasis on lazy-loading performance and plugin ecosystem exploration.

## Core Value Propositions

### For User

- **Deferred-by-default startup**: every spec inherits `lazy = true`; nothing loads
  without a trigger
- **Portable across machines**: one config runs on Linux, WSL, Windows and macOS,
  branching on detected capability rather than per-machine forks
- **Experimentation-friendly**: plugins are vendored one-subdirectory-at-a-time and
  can be parked with `cond = false` instead of deleted
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
- **Scaffolded vendoring**: `task plugin-setup -- <url>` clones the source and lays
  down the spec skeleton, so adding a plugin is a filled-in template, not a blank file
- **Colorscheme catalog**: candidates tracked in `lua/colorschemes/colorschemes-list.md`;
  active theme is tokyonight
- **Denops ecosystem**: Dedicated `lua/denops-plugins/` category, gated off by default
  and enabled only on machines with Deno (`lua/config/denops.lua`)

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

- Clear module boundaries (lua/config one-concern modules, after/ftplugin, after/lsp,
  lua/plugins, lua/colorschemes)
- Silent-failure classes caught by drift guards (`task check-keys`, `task check-options-sync`)
  rather than by review
- TODOs tracked in place (rust-analyzer, LSP configs)
- EditorConfig + StyLua + Selene enforcement, all clean

### User Experience

- Explicit configuration over implicit defaults: `lua/config/options.lua` states every
  option, so "unset" is a visible decision rather than an omission
- Progressive disclosure (start minimal, enable features as needed)
- Documentation accessibility (CLAUDE.md, neovim_tips/, docs/, per-plugin notes under
  `lua/plugins/docs/`)

## Active Plugins

Active plugins are cataloged in `lua/plugins/` (one subdirectory per plugin). Run `ls lua/plugins/` for the full list. Categories span UI, LSP, Git, navigation, editing, notes, media, Denops, and tooling integrations.

## Out of Scope

- Pre-configured IDE-like experience (user enables what they need)
- Opinionated global keybindings — `lua/config/mappings.lua` holds only double-Esc
  nohlsearch; everything else is scoped to the plugin that owns it via its `keys.lua`
- One-size-fits-all plugin selection (vendor per plugin, park with `cond = false`)
- Per-machine config forks — machine differences are expressed as capability checks
  inside the one config

