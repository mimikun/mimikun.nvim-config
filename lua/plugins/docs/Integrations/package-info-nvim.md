# Integrations

## vuki656/package-info.nvim

### nvim-telescope/telescope.nvim

```lua
require("telescope").setup({
    extensions = {
        package_info = {
            -- Optional theme (the extension doesn't set a default theme)
            theme = "ivy",
        },
    },
})

require("telescope").load_extension("package_info")
```

### Any status-line plugin

- It can be used anywhere in `neovim` by invoking `return require('package-info').get_status()`

```lua
local package_info = require("package-info")

-- Galaxyline
section.left[10] = {
    PackageInfoStatus = {
        provider = function()
            return package_info.get_status()
        end,
    },
}

-- Feline
components.right.active[5] = {
    provider = function()
        return package_info.get_status()
    end,
    hl = {
        style = "bold",
    },
    left_sep = "  ",
    right_sep = " ",
}
```

