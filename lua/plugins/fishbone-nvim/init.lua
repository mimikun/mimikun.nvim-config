---@type LazySpec
local spec = {
  "alchezar/fishbone.nvim",
  --lazy = false,
  event = require("plugins.fishbone-nvim.events"),
  --opts = require("plugins.fishbone-nvim.opts"),
  config = function()
    local opts = require("plugins.fishbone-nvim.opts")
    require("fishbone").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
