---@type LazySpec
local spec = {
  "folke/snacks.nvim",
  lazy = false,
  keys = require("plugins.snacks-nvim.keys"),
  --opts = require("plugins.snacks-nvim.opts"),
  config = function()
    local opts = require("plugins.snacks-nvim.opts")
    require("snacks").setup(opts)
  end,
  priority = 1000,
  --cond = false,
  --enabled = false,
}

return spec
