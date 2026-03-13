---@type LazySpec
local spec = {
  "skanehira/github-actions.nvim",
  --lazy = false,
  ft = require("plugins.github-actions-nvim.ft"),
  cmd = require("plugins.github-actions-nvim.cmds"),
  keys = require("plugins.github-actions-nvim.keys"),
  event = require("plugins.github-actions-nvim.events"),
  dependencies = require("plugins.github-actions-nvim.dependencies"),
  opts = require("plugins.github-actions-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
