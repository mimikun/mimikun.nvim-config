---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>b",
    mode = {
      "n",
    },
    desc = "Brewfile",
    silent = true,
  },
  {
    "<leader>bi",
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
    "<leader>br",
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
    "<leader>bo",
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
    "<leader>bd",
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
    "<leader>bD",
    function()
      require("brewfile").force_uninstall()
    end,
    desc = "Brew force uninstall package",
    silent = true,
  },
  {
    "<leader>bI",
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
    "<leader>bu",
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
