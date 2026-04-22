---@type LazySpec
local spec = {
  "delphinus/md-render.nvim",
  --lazy = false,
  --version = "*",
  ft = require("plugins.md-render-nvim.ft"),
  cmd = require("plugins.md-render-nvim.cmds"),
  keys = require("plugins.md-render-nvim.keys"),
  event = require("plugins.md-render-nvim.events"),
  dependencies = require("plugins.md-render-nvim.dependencies"),
  --cond = false,
  --enabled = false,
}

return spec
