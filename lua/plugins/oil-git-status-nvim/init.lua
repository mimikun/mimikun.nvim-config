---@type LazySpec
local spec = {
  "refractalize/oil-git-status.nvim",
  lazy = false,
  dependencies = require("plugins.oil-git-status-nvim.dependencies"),
  opts = require("plugins.oil-git-status-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
