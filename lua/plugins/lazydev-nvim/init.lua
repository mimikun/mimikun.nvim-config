---@type LazySpec
local spec = {
  "folke/lazydev.nvim",
  --lazy = false,
  ft = require("plugins.lazydev-nvim.ft"),
  cmd = require("plugins.lazydev-nvim.cmds"),
  dependencies = require("plugins.lazydev-nvim.dependencies"),
  opts = require("plugins.lazydev-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
