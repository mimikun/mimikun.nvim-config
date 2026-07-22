---@type LazySpec
local spec = {
  "simonmclean/triptych.nvim",
  --lazy = false,
  cmd = require("plugins.triptych-nvim.cmds"),
  keys = require("plugins.triptych-nvim.keys"),
  event = require("plugins.triptych-nvim.events"),
  dependencies = require("plugins.triptych-nvim.dependencies"),
  --opts = require("plugins.triptych-nvim.opts"),
  config = function()
    local opts = require("plugins.triptych-nvim.opts")
    require("triptych").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
