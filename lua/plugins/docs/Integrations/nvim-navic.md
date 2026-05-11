# Integrations

## SmiteshP/nvim-navic

### Native method

```lua
vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
--  OR
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
```

### feline-nvim/feline.nvim

```lua
local navic = require("nvim-navic")

table.insert(components.active[1], {
  provider = function()
    return navic.get_location()
  end,
  enabled = function()
    return navic.is_available()
  end
})

require("feline").setup({components = components})
--  OR
require("feline").winbar.setup({components = components})
```

### nvim-lualine/lualine.nvim

```lua
local navic = require("nvim-navic")

require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "navic",
        -- Component specific options
        -- This option is useful only when you have highlights enabled.
        -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
        -- Setting it to "static" will perform a adjustment once when the component is being setup. 
        -- This should be enough when the lualine section isn't changing colors based on the mode.
        -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for the current section.
        ---@type string | "static" | "dynamic" | nil
        color_correction = nil, 
  
        -- lua table with same format as setup's option. 
        -- All options except "lsp" options take effect when set here.
        navic_opts = nil,
      }
    }
  },
  -- OR in winbar
  winbar = {
    lualine_c = {
      {
        "navic",
        color_correction = nil,
        navic_opts = nil
      }
    }
  }
})

-- OR a more hands on approach
require("lualine").setup({
  sections = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      },
    }
  },
  -- OR in winbar
  winbar = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      },
    }
  }
})
```

### glepnir/galaxyline.nvim

```lua
local navic = require("nvim-navic")
local gl = require("galaxyline")

gl.section.right[1]= {
  nvimNavic = {
    provider = function()
      return navic.get_location()
    end,
    condition = function()
      return navic.is_available()
    end
  }
}
```

