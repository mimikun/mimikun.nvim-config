---@type LazySpec
local spec = {
  "aikhe/wrapped.nvim",
  --lazy = false,
  cmd = require("plugins.wrapped-nvim.cmds"),
  dependencies = require("plugins.wrapped-nvim.dependencies"),
  opts = require("plugins.wrapped-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
