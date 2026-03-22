---@type LazySpec
local spec = {
  "renerocksai/telekasten.nvim",
  --lazy = false,
  cmd = require("plugins.telekasten-nvim.cmds"),
  keys = require("plugins.telekasten-nvim.keys"),
  event = require("plugins.telekasten-nvim.events"),
  dependencies = require("plugins.telekasten-nvim.dependencies"),
  opts = require("plugins.telekasten-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
