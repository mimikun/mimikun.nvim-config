---@type LazySpec
local spec = {
  "xvzc/chezmoi.nvim",
  --lazy = false,
  cmd = require("plugins.chezmoi-nvim.cmds"),
  keys = require("plugins.chezmoi-nvim.keys"),
  event = require("plugins.chezmoi-nvim.events"),
  dependencies = require("plugins.chezmoi-nvim.dependencies"),
  opts = require("plugins.chezmoi-nvim.opts"),
  cond = false,
  enabled = false,
}

return spec
