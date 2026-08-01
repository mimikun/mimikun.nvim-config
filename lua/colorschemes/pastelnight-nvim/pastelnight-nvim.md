# pastelnight.nvim

## 🔌 Other supported plugins

### [Barbecue](https://github.com/utilyre/barbecue.nvim)

```lua
require('barbecue').setup {
  theme = 'pastelnight',
}
```

#### [Lualine](https://github.com/nvim-lualine/lualine.nvim)

```lua
require('lualine').setup {
  options = {
    theme = 'pastelnight'
  }
}
```

##### [Lightline](https://github.com/itchyny/lightline.vim)

```vim
let g:lightline = {'colorscheme': 'pastelnight'}
```

### Borderless Telescope example

```lua
require("pastelnight").setup({
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})
```
