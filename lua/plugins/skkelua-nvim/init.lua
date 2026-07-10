---@type LazySpec
local spec = {
  "kjuq/skkelua.nvim",
  --lazy = false,
  keys = require("plugins.skkelua-nvim.keys"),
  event = require("plugins.skkelua-nvim.events"),
  --opts = require("plugins.skkelua-nvim.opts"),
  config = function()
    local opts = require("plugins.skkelua-nvim.opts")
    require("skkelua").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
