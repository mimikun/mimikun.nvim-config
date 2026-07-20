---@type LazySpec
local spec = {
  "vxpm/ferris.nvim",
  --lazy = false,
  ft = require("plugins.ferris-nvim.ft"),
  cmd = require("plugins.ferris-nvim.cmds"),
  event = require("plugins.ferris-nvim.events"),
  --opts = require("plugins.ferris-nvim.opts"),
  config = function()
    local opts = require("plugins.ferris-nvim.opts")
    require("ferris").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
