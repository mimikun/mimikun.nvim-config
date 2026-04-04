---@type LazySpec
local spec = {
  "folke/twilight.nvim",
  --lazy = false,
  cmd = require("plugins.twilight-nvim.cmds"),
  event = require("plugins.twilight-nvim.events"),
  opts = require("plugins.twilight-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
