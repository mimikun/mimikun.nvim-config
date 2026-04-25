### My statusline/tabline/winbar updates infrequently

By default lualine updates statusline, tabline & winbar every 1s. If you need faster update you can configure the update time with refresh option.
```lua
require('lualine').setup({
  options = {
    refresh = {
      statusline = 200,  -- Note these are in mili second and default is 1000
      tabline = 500,
      winbar = 300,
    }
  }
}
```

You can also refresh lualine at any point by calling `require('lualine').refresh()`. See [here](https://github.com/nvim-lualine/lualine.nvim#refreshing-lualine) for more info on `refresh()`.

For example you can add an auto-command that refreshes lualine on `CursorMoved` event like this

```lua
vim.api.nvim_create_autocmd('CursorMoved', {callback=require('lualine').refresh})
```