---@type LazySpec
local spec = {
  "nvimdev/visualizer.nvim",
  --lazy = false,
  cmd = require("plugins.visualizer-nvim.cmds"),
  event = require("plugins.visualizer-nvim.events"),
  --cond = false,
  --enabled = false,
}

return spec
