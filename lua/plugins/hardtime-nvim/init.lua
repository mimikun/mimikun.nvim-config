---@type LazySpec
local spec = {
  "m4xshen/hardtime.nvim",
  lazy = false,
  cmd = require("plugins.hardtime-nvim.cmds"),
  dependencies = require("plugins.hardtime-nvim.dependencies"),
  opts = require("plugins.hardtime-nvim.opts"),
  cond = false,
  enabled = false,
}

return spec
