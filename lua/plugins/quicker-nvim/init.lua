---@type LazySpec
local spec = {
  "stevearc/quicker.nvim",
  --lazy = false,
  ft = require("plugins.quicker-nvim.ft"),
  keys = require("plugins.quicker-nvim.keys"),
  event = require("plugins.quicker-nvim.events"),
  --opts = require("plugins.quicker-nvim.opts"),
  config = function()
    local opts = require("plugins.quicker-nvim.opts")
    require("quicker").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
