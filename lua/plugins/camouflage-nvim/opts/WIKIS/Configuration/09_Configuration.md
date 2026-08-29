# Configuration

camouflage.nvim is configured through the `setup()` function. All options are optional — the plugin works with zero configuration.

## Full Configuration Reference

```lua
require('camouflage').setup({
  -- General
  enabled = true,              -- Enable/disable the plugin
  debug = false,               -- Enable verbose debug logging
  auto_enable = true,          -- Automatically mask on file open
  debounce_ms = 150,           -- Masking delay in ms (0 = instant)
  max_lines = 5000,            -- Skip files larger than this

  -- Appearance
  style = 'stars',             -- 'text' | 'dotted' | 'stars' | 'scramble'
  mask_char = '*',             -- Character for stars/dotted style
  mask_length = nil,           -- nil = actual length, number = fixed
  hidden_text = '************************',  -- For 'text' style
  highlight_group = 'Comment', -- Highlight group for masked text

  -- Custom colors (overrides highlight_group when set)
  colors = {
    foreground = '#808080',       -- Text color (hex or color name)
    background = 'transparent',   -- Background ('transparent' or hex)
    bold = false,
    italic = false,
  },

  -- Parser settings
  parsers = {
    include_commented = true,      -- Include commented lines (all parsers)
    env = {
      include_export = true,       -- Include export KEY=value
    },
    json = {
      max_depth = 10,              -- Maximum nesting depth
    },
    yaml = {
      max_depth = 10,              -- Maximum nesting depth
    },
    xml = {
      max_depth = 10,              -- Maximum nesting depth
    },
    hcl = {
      max_depth = 10,              -- Maximum block nesting depth
    },
  },

  -- Integrations
  integrations = {
    telescope = true,              -- Mask values in Telescope preview
    cmp = {
      disable_in_masked = true,    -- Disable completion in masked buffers
    },
  },

  -- Reveal settings
  reveal = {
    highlight_group = 'CamouflageRevealed',  -- Highlight for revealed values
    notify = false,                           -- Show notifications
    follow_cursor = false,                    -- Auto-reveal current line
  },

  -- Yank settings
  yank = {
    default_register = '+',       -- System clipboard
    notify = true,                -- Show notification after copy
    auto_clear_seconds = 30,      -- Auto-clear clipboard (nil to disable)
    confirm = true,               -- Require confirmation before copying
    confirm_message = 'Copy value of "%s" to clipboard?',
  },

  -- Have I Been Pwned integration (requires Neovim 0.10+)
  -- `pwned` is kept for compatibility and is mirrored into `checks.pwned`.
  pwned = {
    enabled = true,
    auto_check = true,            -- Check on BufEnter
    check_on_save = true,         -- Check on BufWritePost
    check_on_change = true,       -- Check on TextChanged with debounce
    show_sign = true,             -- Show sign column indicator
    show_virtual_text = true,     -- Show virtual text with breach count
    show_line_highlight = true,   -- Highlight the line
    sign_text = '!',
    sign_hl = 'DiagnosticWarn',
    virtual_text_format = 'PWNED (%s)',
    virtual_text_hl = 'DiagnosticWarn',
    line_hl = 'CamouflagePwned',
  },

  -- Per-value checks (shared badges renderer)
  checks = {
    badges = {
      position = 'right_align',   -- 'right_align' | 'eol' | 'inline'
      separator = ' ',
      separator_hl = 'Comment',
    },
    expiry = {
      enabled = true,
      show_threshold_seconds = 86400,   -- show badge when < 24h left
      warn_threshold_seconds = 3600,    -- warning color when < 1h left
      show_provider = true,             -- include name from iss claim
      refresh = { auto_interval = 60 }, -- background timer seconds, 0 disables
    },
    weak_secret = {
      enabled = true,
      min_length = 8,
      min_sensitive_length = 12,
      entropy_threshold = 3.0,
      sensitive_key_patterns = {
        'password',
        'passwd',
        'passphrase',
        'secret',
        'token',
        'api[_%-]*key',
        'access[_%-]*key',
        'private[_%-]*key',
        'client[_%-]*secret',
        'auth[_%-]*token',
        'credential',
      },
      ignored_key_patterns = {},
      ignored_value_patterns = {},
      common_values = {
        'password',
        'password1',
        'password123',
        'secret',
        'secret123',
        'changeme',
        'changeit',
        'admin',
        'default',
        'test',
        'testing',
        'demo',
        'dummy',
        'qwerty',
        'letmein',
        'welcome',
        'hunter2',
      },
      show_sign = false,
      sign_text = '!',
      sign_hl = 'DiagnosticWarn',
      show_virtual_text = true,
      virtual_text_format = '[weak: %s]',
      virtual_text_hl = 'DiagnosticWarn',
      line_hl = nil,
    },
    -- Legacy `pwned = { ... }` above is mirrored into checks.pwned automatically.
    -- Registered public checks also read data-only options from checks.<name>.
  },

  -- Workspace audit
  audit = {
    ignore_patterns = { '.git', '.git/**', 'node_modules', 'node_modules/**' },
    max_files_per_chunk = 50,
    destination = 'quickfix',     -- 'quickfix' | 'loclist'
    open = true,
    notify = true,
  },

  -- Data-only masking policy
  policy = {
    enabled = true,
    default_action = 'mask',      -- 'mask' | 'ignore'
    terminal_path_ignores = {},
    rules = {
      -- {
      --   id = 'ignore-debug-flags',
      --   action = 'ignore',
      --   key = { '^DEBUG$', '^PORT$' },
      --   parser = { 'env', 'json', 'yaml' },
      -- },
    },
  },

  -- Project config
  project_config = {
    enabled = true,
    filename = '.camouflage.yaml',
    notify = true,
    secure = false,               -- Gate project config behind vim.secure/:trust
    watch_enabled = true,
    watch_backend = 'auto',       -- 'auto' | 'autocmd' | 'fs' | 'both'
    watch_debounce_ms = 200,
    max_watched_roots = 10,
    notify_on_reload = false,
  },

  -- Custom file patterns
  custom_patterns = {},

  -- Event hooks
  hooks = {
    on_before_decorate = function(bufnr, filename) end,
    on_variable_detected = function(bufnr, var) end,
    on_after_decorate = function(bufnr, variables) end,
  },
})
```

## General Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enabled` | `boolean` | `true` | Enable or disable the plugin globally |
| `debug` | `boolean` | `false` | Enable verbose debug logging (view with `:messages`) |
| `auto_enable` | `boolean` | `true` | Automatically mask values when opening supported files |
| `debounce_ms` | `number` | `150` | Delay (ms) before re-applying masks after text changes. Set to `0` for instant masking |
| `max_lines` | `number` | `5000` | Skip masking for files larger than this many lines (performance guard) |

## Appearance Options

### Masking Styles

| Style | Description | Example |
|-------|-------------|---------|
| `stars` | Replace with mask character | `my_secret` → `*********` |
| `dotted` | Replace with bullet character | `my_secret` → `•••••••••` |
| `text` | Replace with fixed text | `my_secret` → `************************` |
| `scramble` | Deterministic character shuffle | `my_secret` → `ms_yecert` |

The `scramble` style preserves the first and last characters, using a deterministic Fisher-Yates shuffle seeded by the content. This means the same value always produces the same scrambled output.

`scramble` is cosmetic, not protective: it leaks the value length and character set. Use `stars`, `dotted`, or `text` when you want lower on-screen exposure.

### Mask Character

```lua
mask_char = '*'    -- Used by 'stars' style (default)
mask_char = '#'    -- Use hash instead
mask_char = 'X'    -- Use X instead
```

### Fixed Mask Length

```lua
mask_length = nil  -- Use actual value length (default)
mask_length = 8    -- Always show 8 mask characters regardless of value length
```

### Custom Colors

When `colors` is set, it creates a custom `CamouflageMask` highlight group that overrides `highlight_group`:

```lua
colors = {
  foreground = '#808080',      -- Hex color or Vim color name
  background = 'transparent',  -- 'transparent' or hex color
  bold = false,
  italic = false,
}
```

## Highlight Groups

camouflage.nvim defines the following highlight groups:

| Group | Default | Purpose |
|-------|---------|---------|
| `CamouflageMask` | Links to `Comment` | Masked values (when `colors` is set) |
| `CamouflageRevealed` | `fg=#1a1b26 bg=#e0af68 bold` | Revealed values (yellow background) |
| `CamouflagePwned` | `bg=#3d1f1f` | Pwned password lines |
| `CamouflagePwnedSign` | `fg=#ff6b6b bold` | Pwned sign column |
| `CamouflagePwnedVirtualText` | `fg=#ff6b6b italic` | Pwned virtual text |

You can override these in your colorscheme:

```lua
vim.api.nvim_set_hl(0, 'CamouflageRevealed', { fg = '#000000', bg = '#ffcc00', bold = true })
```

## Configuration Layers

camouflage.nvim supports multiple configuration layers with the following merge precedence (later overrides earlier):

1. **Defaults** — Built-in default values
2. **`setup()` options** — Your `require('camouflage').setup({...})` call
3. **Project config** — `.camouflage.yaml` in the project root
4. **Buffer-local overrides** — `vim.b.camouflage_*` variables

See [[Project Config]] and [[Buffer Local Config]] for details on layers 3 and 4.

## Hot Reload

Configuration changes via `config.set()` are applied immediately — the plugin automatically refreshes all visible buffers when settings change.

## Workspace Audit Options

`audit` configures `:CamouflageAudit`, which scans supported files into quickfix or location-list without returning plaintext values.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ignore_patterns` | `string[]` | `{'.git', '.git/**', 'node_modules', 'node_modules/**'}` | Root-relative or basename globs skipped by audit |
| `max_files_per_chunk` | `integer` | `50` | Number of files processed per scheduled async chunk |
| `destination` | `'quickfix' \| 'loclist'` | `'quickfix'` | Default result list target |
| `open` | `boolean` | `true` | Open the list after findings are written |
| `notify` | `boolean` | `true` | Show audit completion notifications |

See [[Workspace Audit]] for command and API details.

## Rule-Based Policy Options

`policy` decides whether already-detected variables should be masked or ignored. It is data-only and works in both `setup()` and `.camouflage.yaml`.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enabled` | `boolean` | `true` | Enable policy evaluation |
| `default_action` | `'mask' \| 'ignore'` | `'mask'` | Fallback action when no rule matches |
| `terminal_path_ignores` | `string[]` | `{}` | Root-relative path globs ignored before ordered rules |
| `rules` | `table[]` | `{}` | Ordered rules using path, parser, key, metadata, and safe value predicates |

See [[Rule Based Policy]] for precedence, predicates, and examples.

## Checks Namespace

`checks` is the canonical namespace for per-value checks and the shared badge renderer.

| Section | Purpose |
|---------|---------|
| `checks.badges` | Shared badge position, separator, and separator highlight |
| `checks.pwned` | Same table as legacy top-level `pwned` |
| `checks.expiry` | JWT expiry hint settings |
| `checks.weak_secret` | Offline weak-secret quality hints |
| `checks.<custom>` | Data-only config for checks registered with `register_check()` |

See [[Weak Secret Check]], [[JWT Expiry Hints]], [[Have I Been Pwned]], and [[Custom Check API]].

## See Also

- [[Project Config]] — Repo-level configuration
- [[Buffer Local Config]] — Per-buffer overrides
- [[Custom Patterns]] — Define patterns for unsupported file types
- [[Workspace Audit]] — Redacted workspace scanning
- [[Rule Based Policy]] — Declarative masking policy
