---@type LazySpec
local spec = {
  "folke/neoconf.nvim",
  --lazy = false,
  cmd = require("plugins.neoconf-nvim.cmds"),
  event = require("plugins.neoconf-nvim.events"),
  --opts = require("plugins.neoconf-nvim.opts"),
  config = function()
    local opts = require("plugins.neoconf-nvim.opts")
    require("neoconf").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
