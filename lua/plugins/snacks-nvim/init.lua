---@type LazySpec
local spec = {
  "folke/snacks.nvim",
  lazy = false,
  --cmd = require("plugins.snacks-nvim.cmds"),
  --cmd = "",
  keys = require("plugins.snacks-nvim.keys"),
  --event = require("plugins.snacks-nvim.events"),
  --event = "VeryLazy",
  dependencies = require("plugins.snacks-nvim.dependencies"),
  init = require("plugins.snacks-nvim.initfunc"),
  opts = require("plugins.snacks-nvim.opts"),
  --config = function()
  --    INIT
  --end,
  priority = 1000,
  --cond = false,
  --enabled = false,
}

return spec
