# Integrations

## saxon1964/neovim-tips

### saghen/blink.cmp

```lua
require('blink.cmp').setup({
  enabled = function()
    return vim.bo.filetype ~= "neovim-tips-search"
  end,
  -- ... rest of your config
})
```

### hrsh7th/nvim-cmp

```lua
require('cmp').setup({
  enabled = function()
    return vim.bo.filetype ~= "neovim-tips-search"
  end,
  -- ... rest of your config
})
```
