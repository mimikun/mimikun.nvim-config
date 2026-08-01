# Integrations

## rose-pine/neovim

### akinsho/bufferline.nvim

```lua
{
    "akinsho/bufferline.nvim",
    event = "ColorScheme",
    config = function()
        require("bufferline").setup({
            highlights = require("rose-pine.plugins.bufferline")
        })
    end
}
```

### NTBBloodbath/galaxyline.nvim

```lua
-- Access colors via galaxyline's recommended naming
-- @example `highlights.blue`, `highlights.yellow`
local highlights = require("rose-pine.plugins.galaxyline")
```

### nvim-lualine/lualine.nvim

```lua
{
    "nvim-lualine/lualine.nvim",
    event = "ColorScheme",
    config = function()
        require("lualine").setup({
            options = {
                --- @usage 'rose-pine' | 'rose-pine-alt'
                theme = "rose-pine"
            }
        })
    end
}
```

### epwalsh/obsidian.nvim

```lua
{
    "epwalsh/obsidian.nvim",
    config = function()
        require("obsidian").setup({
            ui = {
                hl_groups = require("rose-pine.plugins.obsidian")
            }
        })
    end
}
```

### akinsho/toggleterm.nvim

```lua
{
    "akinsho/toggleterm.nvim",
    event = "ColorScheme",
    config = function()
        require("toggleterm").setup({
            highlights = require("rose-pine.plugins.toggleterm")
        })
    end
}
```
