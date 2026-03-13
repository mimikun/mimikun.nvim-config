---@type LazySpec
local spec = {
  "lewis6991/gitsigns.nvim",
  --lazy = false,
  cmd = require("plugins.gitsigns-nvim.cmds"),
  event = require("plugins.gitsigns-nvim.events"),
  dependencies = require("plugins.gitsigns-nvim.dependencies"),
  --opts = require("plugins.gitsigns-nvim.opts"),
  config = function()
    local opts = require("plugins.gitsigns-nvim.opts")
    require("gitsigns").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
