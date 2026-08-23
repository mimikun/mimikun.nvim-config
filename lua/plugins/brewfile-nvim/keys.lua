---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>B",
    mode = {
      "n",
    },
    desc = "Brewfile",
    silent = true,
  },
  {
    "<leader>Bi",
    function()
      require("brewfile").install()
    end,
    mode = {
      "n",
    },
    desc = "Brew install package",
    silent = true,
  },
  {
    "<leader>Br",
    function()
      require("brewfile").dump()
    end,
    mode = {
      "n",
    },
    desc = "Dump Brewfile and refresh the buffer",
    silent = true,
  },
  {
    "<leader>Bo",
    function()
      require("brewfile").open_homepage()
    end,
    mode = {
      "n",
    },
    desc = "Open package homepage",
    silent = true,
  },
  {
    "<leader>Bd",
    function()
      require("brewfile").uninstall()
    end,
    mode = {
      "n",
    },
    desc = "Brew uninstall package",
    silent = true,
  },
  {
    "<leader>BD",
    function()
      require("brewfile").force_uninstall()
    end,
    desc = "Brew force uninstall package",
    silent = true,
  },
  {
    "<leader>BI",
    function()
      require("brewfile").info()
    end,
    mode = {
      "n",
    },
    desc = "Brew package info",
    silent = true,
  },
  {
    "<leader>Bu",
    function()
      require("brewfile").upgrade()
    end,
    mode = {
      "n",
    },
    desc = "Brew upgrade package",
    silent = true,
  },
}

return keys
