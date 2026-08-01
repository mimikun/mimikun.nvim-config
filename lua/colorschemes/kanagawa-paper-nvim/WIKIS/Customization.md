### Where can I see the full color palette?

The visual palette is [here](https://github.com/thesimonho/kanagawa-paper.nvim/blob/master/palette_colors.md), and is automatically updated whenever colors are added/changed.

### Customizations aren't being applied

Are you using the `cache` option? If so, try forcing a cache rebuild with `:KanagawaPaperCache`

### Theme reloading

If you're making tweaks to the theme colors and want to see your changes without restarting neovim every time, you can simply unload and reload the package. For example, I have this function bound to a keymap:

```lua
function reload()
  for k in pairs(package.loaded) do
    if k:match("^kanagawa%-paper") then
      package.loaded[k] = nil
    end
  end
  require("kanagawa-paper").setup(opts)  -- reload with whatever `opts` table you want
  vim.cmd.colorscheme("kanagawa-paper")
end
```

### Switch theme by time of day

This theme relies on `vim.o.background` to determine whether the light or dark variant should be used. Because of that, you can use something like this to switch themes depending on the current time of day:

```lua
local hour = os.date("*t").hour
vim.o.background = (hour >= 7 and hour < 19) and "light" or "dark"
```
If you're feeling adventurous you can also map that to an autocmd so you don't need to restart neovim to see the change.