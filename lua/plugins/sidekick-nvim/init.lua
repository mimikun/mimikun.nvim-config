---@type LazySpec
local spec = {
  "folke/sidekick.nvim",
  --lazy = false,
  cmd = require("plugins.sidekick-nvim.cmds"),
  keys = require("plugins.sidekick-nvim.keys"),
  event = require("plugins.sidekick-nvim.events"),
  dependencies = require("plugins.sidekick-nvim.dependencies"),
  --init = function()
  --    INIT
  --end,
  opts = require("plugins.sidekick-nvim.opts"),
  --config = function()
  --    INIT
  --end,
  --cond = false,
  --enabled = false,
}

return spec
