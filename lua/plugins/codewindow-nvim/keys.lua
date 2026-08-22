---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>mo",
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
    "<leader>mf",
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
    "<leader>mc",
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
    "<leader>mm",
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
