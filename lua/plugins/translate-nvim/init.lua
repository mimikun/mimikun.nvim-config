---@type LazySpec
local spec = {
  "uga-rosa/translate.nvim",
  --lazy = false,
  cmd = require("plugins.translate-nvim.cmds"),
  keys = require("plugins.translate-nvim.keys"),
  event = require("plugins.translate-nvim.events"),
  --opts = require("plugins.translate-nvim.opts"),
  config = function()
    local opts = require("plugins.translate-nvim.opts")
    require("translate").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
