---@type LazySpec
local spec = {
  "folke/trouble.nvim",
  --lazy = false,
  cmd = require("plugins.trouble-nvim.cmds"),
  keys = require("plugins.trouble-nvim.keys"),
  event = require("plugins.trouble-nvim.events"),
  dependencies = require("plugins.trouble-nvim.dependencies"),
  opts = require("plugins.trouble-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
