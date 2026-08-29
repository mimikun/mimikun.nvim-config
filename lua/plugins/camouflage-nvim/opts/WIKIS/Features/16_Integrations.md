# Integrations

camouflage.nvim integrates with several popular Neovim plugins to provide masking in different contexts.

## Telescope

When Telescope integration is enabled, sensitive values are masked in Telescope preview buffers. This prevents accidental exposure when searching/browsing files with `:Telescope find_files`, `:Telescope live_grep`, etc.

### Configuration

```lua
require('camouflage').setup({
  integrations = {
    telescope = true,  -- Enabled by default
  },
})
```

### How It Works

1. Listens for `User TelescopePreviewerLoaded` events
2. When a preview buffer loads a supported file, masking is automatically applied
3. Masking is applied using the same parsers and styles as regular buffers

### Requirements

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) must be installed and loaded

## Snacks.nvim (Picker)

camouflage.nvim automatically masks values in [Snacks.nvim](https://github.com/folke/snacks.nvim) picker preview buffers. This integration is **always enabled** when Snacks.nvim is detected — no configuration needed.

### How It Works

1. Detects Snacks picker preview windows via the `snacks_picker_preview` window variable
2. Attaches to preview buffers to detect content changes
3. Uses multiple methods to resolve the filename: Snacks picker item, buffer name, window title
4. Applies masking with debouncing (10ms) to avoid redundant decoration

### Supported Events

The integration starts tracking when Snacks picker input/list buffers appear (`FileType` events for `snacks_picker_input` and `snacks_picker_list`). While at least one picker session is open, `BufWinEnter`, `WinEnter`, and `CursorMoved` schedule lightweight preview scans. Outside active picker sessions there is no steady-state cursor-move work.

## nvim-cmp

When enabled, camouflage disables [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) completion in buffers that have masked values. This prevents accidental secret exposure through the completion menu.

### Configuration

```lua
require('camouflage').setup({
  integrations = {
    cmp = {
      disable_in_masked = true,  -- Enabled by default
    },
  },
})
```

### How It Works

On `BufEnter`, if the buffer has masked values, `cmp.setup.buffer({ enabled = false })` is called to disable completion for that buffer only.

## Lualine

camouflage.nvim provides a built-in [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) component that shows the masking status in your statusline.

### Basic Setup

```lua
require('lualine').setup({
  sections = {
    lualine_x = { 'camouflage' },
  },
})
```

### Custom Options

```lua
require('lualine').setup({
  sections = {
    lualine_x = {
      {
        'camouflage',
        icon_enabled = '',          -- Icon when enabled (default)
        icon_disabled = '',         -- Icon when disabled
        show_disabled = false,       -- Show component when disabled
        show_count = true,           -- Show masked values count
        show_follow_indicator = true,-- Show [F] when follow mode active
        follow_indicator = '[F]',    -- Custom follow mode indicator
      },
    },
  },
})
```

### Component Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `icon_enabled` | `string` | `''` | Icon shown when camouflage is enabled |
| `icon_disabled` | `string` | `''` | Icon shown when camouflage is disabled |
| `show_disabled` | `boolean` | `false` | Whether to show the component when disabled |
| `show_count` | `boolean` | `false` | Show the number of masked variables |
| `show_follow_indicator` | `boolean` | `true` | Show indicator when follow mode is active |
| `follow_indicator` | `string` | `[F]` | Text for the follow mode indicator |

### Example Output

| State | Output |
|-------|--------|
| Enabled, 5 masked | ` 5` |
| Enabled, follow mode, 5 masked | ` 5 [F]` |
| Disabled | (hidden, unless `show_disabled = true`) |
| Disabled with `show_disabled` | `` |

### Visibility

The component is only visible when the current buffer is a supported file type. For non-supported files, it returns an empty string and lualine hides it.

## See Also

- [[Configuration]] — Integration configuration options
- [[Getting Started]] — Basic setup including integrations
