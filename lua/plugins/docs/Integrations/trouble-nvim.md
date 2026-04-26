# Integrations

## folke/trouble.nvim

### nvim-telescope/telescope.nvim

You can easily open any search results in **Trouble**, by defining a custom action:

```lua
local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
```

When you open telescope, you can now hit `<c-t>` to open the results in **Trouble**

### fzf-lua

You can easily open any search results in **Trouble**, by defining a custom action:

```lua
local config = require("fzf-lua.config")
local actions = require("trouble.sources.fzf").actions
config.defaults.actions.files["ctrl-t"] = actions.open
```

When you open fzf-lua, you can now hit `<c-t>` to open the results in **Trouble**

### nvim-lualine/lualine.nvim

Example for [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):

```lua
{
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })
    table.insert(opts.sections.lualine_c, {
      symbols.get,
      cond = symbols.has,
    })
  end,
}
```

