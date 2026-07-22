---@type LazySpec
local spec = {
  "folke/styler.nvim",
  --lazy = false,
  ft = require("plugins.styler-nvim.ft"),
  cmd = require("plugins.styler-nvim.cmds"),
  event = require("plugins.styler-nvim.events"),
  --opts = require("plugins.styler-nvim.opts"),
  config = function()
    local opts = require("plugins.styler-nvim.opts")
    require("styler").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
