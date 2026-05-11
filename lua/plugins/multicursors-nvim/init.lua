---@type LazySpec
local spec = {
  "smoka7/multicursors.nvim",
  --lazy = false,
  cmd = require("plugins.multicursors-nvim.cmds"),
  keys = require("plugins.multicursors-nvim.keys"),
  event = require("plugins.multicursors-nvim.events"),
  dependencies = require("plugins.multicursors-nvim.dependencies"),
  --opts = require("plugins.multicursors-nvim.opts"),
  config = function()
    local opts = require("plugins.multicursors-nvim.opts")
    require("multicursors").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
