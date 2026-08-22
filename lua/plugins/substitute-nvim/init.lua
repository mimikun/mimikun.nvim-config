---@type LazySpec
local spec = {
  "gbprod/substitute.nvim",
  --lazy = false,
  keys = require("plugins.substitute-nvim.keys"),
  event = require("plugins.substitute-nvim.events"),
  dependencies = require("plugins.substitute-nvim.dependencies"),
  --opts = require("plugins.substitute-nvim.opts"),
  config = function()
    local opts = require("plugins.substitute-nvim.opts")
    require("substitute").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
