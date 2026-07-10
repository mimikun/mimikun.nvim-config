# Have I Been Pwned Integration

camouflage.nvim can check your masked passwords against the [Have I Been Pwned](https://haveibeenpwned.com/) breach database. This helps identify passwords that have been exposed in known data breaches.

## Requirements

- **Neovim 0.10+** (uses `vim.system()` for async execution)
- **curl** — for API requests

SHA-1 hashing is done in-process with camouflage's bundled pure-Lua implementation. No `sha1sum`, `openssl`, or shell hashing command is required.

## How It Works

The integration uses **k-anonymity** to protect your privacy:

1. Your password is hashed with SHA-1
2. Only the **first 5 characters** of the hash are sent to the API
3. The API returns all hash suffixes matching that prefix
4. The comparison happens **locally** on your machine

**Your actual passwords never leave your machine.**

### Technical Flow

```
Password → SHA-1 hash → Split: prefix (5 chars) + suffix (35 chars)
                              ↓
                    Send prefix to API
                              ↓
                    Receive list of matching suffixes
                              ↓
                    Local comparison: suffix match?
                              ↓
                    Display result (sign, virtual text, highlight)
```

## Configuration

```lua
require('camouflage').setup({
  checks = {
    pwned = {
      enabled = true,               -- Feature toggle
      auto_check = true,            -- Check on BufEnter
      check_on_save = true,         -- Check when saving file
      check_on_change = true,       -- Check on text changes (debounced)
      show_sign = true,             -- Show sign column indicator
      show_virtual_text = true,     -- Show virtual text with breach count
      show_line_highlight = true,   -- Highlight the entire line
      sign_text = '!',              -- Sign icon
      sign_hl = 'DiagnosticWarn',   -- Sign highlight group
      virtual_text_format = 'PWNED (%s)',   -- Virtual text format (%s = count)
      virtual_text_hl = 'DiagnosticWarn',   -- Virtual text highlight
      line_hl = 'CamouflagePwned',          -- Line highlight group
    },
  },
})
```

The legacy top-level `pwned = { ... }` key is still supported and is mirrored into `checks.pwned`.

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enabled` | `boolean` | `true` | Enable/disable the entire HIBP feature |
| `auto_check` | `boolean` | `true` | Automatically check when entering a buffer |
| `check_on_save` | `boolean` | `true` | Check after saving the file |
| `check_on_change` | `boolean` | `true` | Check on text changes (500ms debounce) |
| `show_sign` | `boolean` | `true` | Show indicator in sign column |
| `show_virtual_text` | `boolean` | `true` | Show breach count as virtual text |
| `show_line_highlight` | `boolean` | `true` | Highlight the line background |
| `sign_text` | `string` | `'!'` | Character shown in sign column |
| `sign_hl` | `string` | `'DiagnosticWarn'` | Highlight group for the sign |
| `virtual_text_format` | `string` | `'PWNED (%s)'` | Format string for virtual text |
| `virtual_text_hl` | `string` | `'DiagnosticWarn'` | Highlight group for virtual text |
| `line_hl` | `string` | `'CamouflagePwned'` | Highlight group for line background |

## Commands

| Command | Description |
|---------|-------------|
| `:CamouflagePwnedCheck` | Check the password under the cursor |
| `:CamouflagePwnedCheckLine` | Check all values on the current line |
| `:CamouflagePwnedCheckBuffer` | Check all values in the entire buffer |
| `:CamouflagePwnedClear` | Clear all pwned indicators |
| `:CamouflagePwnedClearCache` | Clear the in-memory result cache |

## Visual Indicators

When a password is found in breaches, three indicators are shown:

1. **Sign column** — An `!` (or custom character) appears in the sign column
2. **Virtual text** — Shows the breach count, e.g., `PWNED (52.3M)`
3. **Line highlight** — The entire line gets a reddish background (`#3d1f1f`)

### Highlight Groups

| Group | Default | Description |
|-------|---------|-------------|
| `CamouflagePwned` | `bg=#3d1f1f` | Line background for pwned passwords |
| `CamouflagePwnedSign` | `fg=#ff6b6b bold` | Sign column indicator |
| `CamouflagePwnedVirtualText` | `fg=#ff6b6b italic` | Virtual text showing breach count |

You can customize these:

```lua
vim.api.nvim_set_hl(0, 'CamouflagePwned', { bg = '#4a1a1a' })
vim.api.nvim_set_hl(0, 'CamouflagePwnedSign', { fg = '#ff0000', bold = true })
```

## Caching

Results are cached in memory to avoid redundant API calls:
- Same password won't be checked twice in the same session
- Use `:CamouflagePwnedClearCache` to force re-checking

## Lua API

```lua
local camouflage = require('camouflage')

camouflage.pwned_check()          -- Check cursor value
camouflage.pwned_check_line()     -- Check current line
camouflage.pwned_check_buffer()   -- Check entire buffer
camouflage.pwned_clear()          -- Clear indicators
camouflage.pwned_is_available()   -- Check if feature is available
```

## Disabling

To disable the feature entirely:

```lua
require('camouflage').setup({
  checks = {
    pwned = {
      enabled = false,
    },
  },
})
```

To disable only auto-checking (manual only):

```lua
require('camouflage').setup({
  checks = {
    pwned = {
      enabled = true,
      auto_check = false,
      check_on_save = false,
      check_on_change = false,
    },
  },
})
```

## See Also

- [[Commands and Keymaps]] — HIBP commands and suggested keybindings
- [[Configuration]] — Full configuration reference
- [[Weak Secret Check]] — offline local weak-secret hints
