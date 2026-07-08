# Integrations

## xeind/vallow.nvim

### nvim-lualine/lualine.nvim

```lua
-- lualine
require("lualine").setup({
  sections = {
    lualine_x = { { require("vallow").statusline, color = { fg = "#f9c74f" } } },
  },
})
```

### Raw statusline

```lua
-- raw
vim.o.statusline = "%{%v:lua.require('vallow').statusline()%}"
```

