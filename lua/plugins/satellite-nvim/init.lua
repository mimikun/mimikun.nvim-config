---@type LazySpec
local spec = {
  "lewis6991/satellite.nvim",
  --lazy = false,
  cmd = require("plugins.satellite-nvim.cmds"),
  event = require("plugins.satellite-nvim.events"),
  dependencies = require("plugins.satellite-nvim.dependencies"),
  --opts = require("plugins.satellite-nvim.opts"),
  config = function()
    local opts = require("plugins.satellite-nvim.opts")
    require("satellite").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
