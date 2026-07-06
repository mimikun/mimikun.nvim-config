---@type LazySpec
local spec = {
  "necrom4/convy.nvim",
  --lazy = false,
  cmd = require("plugins.convy-nvim.cmds"),
  keys = require("plugins.convy-nvim.keys"),
  event = require("plugins.convy-nvim.events"),
  --opts = require("plugins.convy-nvim.opts"),
  config = function()
    local opts = require("plugins.convy-nvim.opts")
    require("convy").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
