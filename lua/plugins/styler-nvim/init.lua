---@type LazySpec
local spec = {
  "folke/styler.nvim",
  --lazy = false,
  ft = require("plugins.styler-nvim.ft"),
  cmd = require("plugins.styler-nvim.cmds"),
  --event = require("plugins.styler-nvim.events"),
  opts = require("plugins.styler-nvim.opts"),
  cond = false,
  enabled = false,
}

return spec
