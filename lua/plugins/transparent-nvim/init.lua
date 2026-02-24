---@type LazySpec
local spec = {
  "xiyaowong/transparent.nvim",
  lazy = false,
  cmd = require("plugins.transparent-nvim.cmds"),
  opts = require("plugins.transparent-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
