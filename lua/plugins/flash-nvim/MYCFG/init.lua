---@type LazySpec
local spec = {
  "folke/flash.nvim",
  --lazy = false,
  keys = require("plugins.flash-nvim.keys"),
  event = require("plugins.flash-nvim.events"),
  dependencies = require("plugins.flash-nvim.dependencies"),
  --opts = require("plugins.flash-nvim.opts"),
  config = function()
    local opts = require("plugins.flash-nvim.opts")
    require("flash").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
