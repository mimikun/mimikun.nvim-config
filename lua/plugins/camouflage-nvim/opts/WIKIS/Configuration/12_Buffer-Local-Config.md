# Buffer-Local Configuration

You can override global settings for specific buffers using Neovim buffer variables (`vim.b`). This is the highest-priority configuration layer.

## Supported Variables

| Variable | Type | Description |
|----------|------|-------------|
| `vim.b.camouflage_enabled` | `boolean` | Enable/disable masking for this buffer |
| `vim.b.camouflage_style` | `string` | Masking style: `'stars'`, `'dotted'`, `'text'`, `'scramble'` |
| `vim.b.camouflage_mask_char` | `string` | Mask character for `stars`/`dotted` style |
| `vim.b.camouflage_mask_length` | `number` | Fixed mask length (overrides actual value length) |
| `vim.b.camouflage_highlight_group` | `string` | Highlight group for masked text |

## Examples

### Disable for a specific buffer

```lua
vim.b.camouflage_enabled = false
```

### Use a different style

```lua
vim.b.camouflage_style = 'scramble'
```

### Custom mask character

```lua
vim.b.camouflage_mask_char = '#'
```

### Fixed mask length

```lua
vim.b.camouflage_mask_length = 8
```

### Different highlight group

```lua
vim.b.camouflage_highlight_group = 'NonText'
```

## Using with Autocommands

The most common use case is setting buffer-local overrides via autocommands for specific file patterns or directories:

### Production files use scramble style

```lua
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*/production/.env*',
  callback = function()
    vim.b.camouflage_style = 'scramble'
  end,
})
```

### Disable masking for example files

```lua
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.example', '*.sample', '*.template' },
  callback = function()
    vim.b.camouflage_enabled = false
  end,
})
```

### Longer masks for staging configs

```lua
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*/staging/*',
  callback = function()
    vim.b.camouflage_mask_length = 16
    vim.b.camouflage_mask_char = 'X'
  end,
})
```

## Important Notes

- Set buffer variables **before** entering the buffer, or call `:CamouflageRefresh` after setting them
- Use the exact variable names: `vim.b.camouflage_enabled` (not `vim.b.camouflage.enabled`)
- Buffer-local settings override all other configuration layers (defaults, setup, project config)

## Configuration Precedence

```
1. Defaults (lowest priority)
2. setup() options
3. Project config (.camouflage.yaml)
4. Buffer-local overrides (highest priority)  ← You are here
```

## See Also

- [[Configuration]] — Global configuration reference
- [[Project Config]] — Repo-level configuration
