# Integrations

## daedlock/matugen.nvim

### nvim-lualine/lualine.nvim

```lua
require("lualine").setup({
  options = { theme = require("matugen").lualine() },
})
```

Re-call this after `User MatugenReloaded` if you want lualine to track wallpaper changes:

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "MatugenReloaded",
  callback = function()
    require("lualine").setup({
      options = { theme = require("matugen").lualine() },
    })
  end,
})
```

