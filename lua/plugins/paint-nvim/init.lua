---@type LazySpec
local spec = {
  "folke/paint.nvim",
  --lazy = false,
  event = require("plugins.paint-nvim.events"),
  opts = require("plugins.paint-nvim.opts"),
  cond = false,
  enabled = false,
}

return spec
