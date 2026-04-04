---@type LazySpec
local spec = {
  "folke/drop.nvim",
  --lazy = false,
  event = require("plugins.drop-nvim.events"),
  opts = require("plugins.drop-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
