-- Key mappings organized by mode (see: fyler.Mapping)
---@type table<string, table<string, fyler.Mapping>>
local mappings = {
  n = {
    ["-"] = {
      action = "visit",
      args = {
        parent = true,
      },
    },
    ["."] = {
      action = "visit",
      args = {
        cursor = true,
      },
    },
    ["<BS>"] = {
      action = "shrink",
      args = {
        parent = true,
      },
    },
    ["<C-R>"] = {
      action = "refresh",
    },
    ["<C-S>"] = {
      action = "select",
      args = {
        split = true,
      },
    },
    ["<C-T>"] = {
      action = "select",
      args = {
        tabedit = true,
      },
    },
    ["<C-V>"] = {
      action = "select",
      args = {
        vsplit = true,
      },
    },
    ["<CR>"] = {
      action = "select",
    },
    ["="] = {
      action = "visit",
    },
    ["g."] = {
      action = "toggle_ui",
      args = {
        "hidden_items",
      },
    },
    ["gi"] = {
      action = "toggle_ui",
      args = {
        "indent_guides",
      },
    },
    ["q"] = {
      action = "close",
    },
  },
}

return mappings
