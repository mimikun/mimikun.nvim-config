# Project Config

camouflage.nvim supports repo-level configuration through a `.camouflage.yaml` file in your project root. This allows teams to enforce consistent masking settings across the repository.

## Creating a Project Config

### Using the Command

```vim
:CamouflageInit
```

This creates a `.camouflage.yaml` template in your project root with all available options documented as comments.

Use `:CamouflageInit!` to overwrite an existing config file.

### Manual Creation

Create `.camouflage.yaml` in your project root:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/zeybek/camouflage.nvim/main/schemas/camouflage-project-config.schema.json
version: 1
style: dotted
debug: true
```

The first line enables YAML editor validation and autocomplete using the project's JSON Schema.

## Configuration Options

The project config supports most options available in `setup()`:

```yaml
version: 1                    # Required. Must be 1

# General
enabled: true
debug: false
auto_enable: true
debounce_ms: 150
max_lines: 5000

# Appearance
style: stars                  # 'text' | 'dotted' | 'stars' | 'scramble'
mask_char: '*'
mask_length: null             # null = actual length, number = fixed
hidden_text: '************************'
highlight_group: Comment

# Colors
colors:
  foreground: '#808080'
  background: transparent
  bold: false
  italic: false

# Parser settings
parsers:
  include_commented: true
  env:
    include_export: true
  json:
    max_depth: 10
  yaml:
    max_depth: 10
  xml:
    max_depth: 10
  hcl:
    max_depth: 10

# Reveal
reveal:
  highlight_group: CamouflageRevealed
  notify: false
  follow_cursor: false

# Yank
yank:
  default_register: '+'
  notify: true
  auto_clear_seconds: 30
  confirm: true

# Have I Been Pwned
pwned:
  enabled: true
  auto_check: true
  check_on_save: true
  check_on_change: true
  show_sign: true
  show_virtual_text: true
  show_line_highlight: true

# Integrations
integrations:
  telescope: true
  cmp:
    disable_in_masked: true

# Workspace audit
audit:
  ignore_patterns: ['.git', '.git/**', 'node_modules', 'node_modules/**']
  max_files_per_chunk: 50
  destination: quickfix        # quickfix | loclist
  open: true
  notify: true

# Rule-based masking policy
policy:
  enabled: true
  default_action: mask         # mask | ignore
  terminal_path_ignores:
    - .git/**
    - node_modules/**
  rules:
    - id: ignore-debug-flags
      action: ignore
      key: ['^DEBUG$', '^PORT$']
      parser: [env, json, yaml]
    - id: force-client-secrets
      action: mask
      allow_force: true
      key:
        - client[_%.%-]?secret
        - private[_%.%-]?key

# Shared check configuration
checks:
  badges:
    position: right_align      # right_align | eol | inline
    separator: ' '
    separator_hl: Comment
  expiry:
    enabled: true
    show_threshold_seconds: 86400
    warn_threshold_seconds: 3600
    show_provider: true
    refresh:
      auto_interval: 60
  weak_secret:
    enabled: true
    min_length: 8
    min_sensitive_length: 12
    entropy_threshold: 3.0
    ignored_key_patterns: []
    ignored_value_patterns: []

# Custom registered checks can also read data-only options here.
# This does not register executable Lua code.
# checks:
#   local_policy:
#     enabled: false
#     label: team
```

> **Note:** The `project_config` section itself cannot be set in the project config (to avoid self-referencing loops). Runtime Lua functions also cannot be loaded from project config; custom check entries under `checks.<name>` are data only.

## Merge Precedence

Configuration is merged in this order (later overrides earlier):

```
1. Defaults (built-in)
   ↓
2. setup() options (your init.lua)
   ↓
3. Project config (.camouflage.yaml)
   ↓
4. Buffer-local overrides (vim.b.camouflage_*)
```

This means project config overrides your personal `setup()` settings. This is intentional — it allows project maintainers to enforce settings for the team.

## File Discovery

camouflage.nvim searches for `.camouflage.yaml` upward from the current file using:

```lua
vim.fn.findfile('.camouflage.yaml', '.;')
```

This means it starts from the current directory and walks up to the filesystem root.

## Validation

The project config is validated against `config.defaults`:
- Unknown keys are rejected with a warning
- Type mismatches are reported
- The `version: 1` field is required

Validation errors are shown as notifications when `project_config.notify = true` (default).

## Security Mode

Project config files are data-only and sanitized by default. If you open untrusted repositories and want Neovim's trust gate, enable secure loading in your personal setup:

```lua
require('camouflage').setup({
  project_config = {
    secure = true,
  },
})
```

With `secure = true`, camouflage reads the project file through `vim.secure.read`. A never-trusted project config is not applied until you view it and run `:trust`.

## File Watcher

camouflage.nvim can watch for changes to `.camouflage.yaml` and reload automatically.

### Watcher Configuration

```lua
require('camouflage').setup({
  project_config = {
    enabled = true,              -- Enable repo config loading
    filename = '.camouflage.yaml',
    notify = true,               -- Show warnings for parse/validation issues
    secure = false,               -- Gate project config behind vim.secure/:trust
    watch_enabled = true,        -- Watch for runtime changes
    watch_backend = 'auto',      -- 'auto' | 'autocmd' | 'fs' | 'both'
    watch_debounce_ms = 200,     -- Debounce for change events
    max_watched_roots = 10,      -- Max roots to watch
    notify_on_reload = false,    -- Notify after successful reload
  },
})
```

### Watch Backends

| Backend | Description |
|---------|-------------|
| `auto` | Uses both `fs` and `autocmd` (recommended) |
| `fs` | Uses libuv `fs_event` for native filesystem watching |
| `autocmd` | Uses `BufWritePost` autocmd to detect saves |
| `both` | Uses both backends simultaneously |

### Status Commands

```vim
:CamouflageProjectConfigStatus       " Show current config status
:CamouflageProjectConfigWatchStatus  " Show watcher status
```

## JSON Schema

A JSON Schema is provided for editor validation:

```
https://raw.githubusercontent.com/zeybek/camouflage.nvim/main/schemas/camouflage-project-config.schema.json
```

Add this comment at the top of your `.camouflage.yaml` for IDE support:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/zeybek/camouflage.nvim/main/schemas/camouflage-project-config.schema.json
```

## See Also

- [[Configuration]] — Full configuration reference
- [[Buffer Local Config]] — Per-buffer overrides (layer 4)
- [[Workspace Audit]] — `audit` configuration
- [[Rule Based Policy]] — `policy` configuration
- [[Weak Secret Check]] — `checks.weak_secret` configuration
