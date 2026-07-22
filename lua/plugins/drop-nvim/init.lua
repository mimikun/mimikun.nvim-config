---@type LazySpec
local spec = {
  "folke/drop.nvim",
  --lazy = false,
  event = require("plugins.drop-nvim.events"),
  --opts = require("plugins.drop-nvim.opts"),
  config = function()
    local opts = require("plugins.drop-nvim.opts")
    require("drop").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
