---@type LazySpec
local spec = {
  "ptdewey/yankbank-nvim",
  --lazy = false,
  cmd = require("plugins.yankbank-nvim.cmds"),
  keys = require("plugins.yankbank-nvim.keys"),
  event = require("plugins.yankbank-nvim.events"),
  dependencies = require("plugins.yankbank-nvim.dependencies"),
  opts = require("plugins.yankbank-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
