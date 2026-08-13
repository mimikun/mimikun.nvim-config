---@type LazySpec
local spec = {
  "piersolenski/brewfile.nvim",
  --lazy = false,
  cmd = require("plugins.brewfile-nvim.cmds"),
  keys = require("plugins.brewfile-nvim.keys"),
  event = require("plugins.brewfile-nvim.events"),
  --opts = require("plugins.brewfile-nvim.opts"),
  config = function()
    local opts = require("plugins.brewfile-nvim.opts")
    require("brewfile").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
