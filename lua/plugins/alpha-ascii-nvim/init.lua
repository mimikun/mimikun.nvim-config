---@type LazySpec
local spec = {
  "nhattVim/alpha-ascii.nvim",
  --lazy = false,
  cmd = require("plugins.alpha-ascii-nvim.cmds"),
  event = require("plugins.alpha-ascii-nvim.events"),
  opts = require("plugins.alpha-ascii-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
