---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Mo",
    function()
      require("codewindow").open_minimap()
    end,
    mode = {
      "n",
    },
    desc = "Open minimap",
    silent = true,
  },
  {
    "<leader>Mf",
    function()
      require("codewindow").toggle_focus()
    end,
    mode = {
      "n",
    },
    desc = "Toggle minimap focus",
    silent = true,
  },
  {
    "<leader>Mc",
    function()
      require("codewindow").close_minimap()
    end,
    mode = {
      "n",
    },
    desc = "Close minimap",
    silent = true,
  },
  {
    "<leader>Mm",
    function()
      require("codewindow").toggle_minimap()
    end,
    mode = {
      "n",
    },
    desc = "Toggle minimap",
    silent = true,
  },
}

return keys
