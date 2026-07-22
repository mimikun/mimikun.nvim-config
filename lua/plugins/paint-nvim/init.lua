---@type LazySpec
local spec = {
  "folke/paint.nvim",
  --lazy = false,
  event = require("plugins.paint-nvim.events"),
  --opts = require("plugins.paint-nvim.opts"),
  config = function()
    local opts = require("plugins.paint-nvim.opts")
    require("paint").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
