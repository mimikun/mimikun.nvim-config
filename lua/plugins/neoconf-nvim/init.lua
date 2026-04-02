---@type LazySpec
local spec = {
  "folke/neoconf.nvim",
  --lazy = false,
  cmd = require("plugins.neoconf-nvim.cmds"),
  event = require("plugins.neoconf-nvim.events"),
  opts = require("plugins.neoconf-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
