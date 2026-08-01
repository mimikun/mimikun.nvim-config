---@type LazySpec
local spec = {
  "Senal-D-A-Gunaratna/matugen.nvim",
  lazy = false,
  cmd = require("colorschemes.matugen-nvim.cmds"),
  event = require("colorschemes.matugen-nvim.events"),
  --opts = require("colorschemes.matugen-nvim.opts"),
  config = function()
    local opts = require("colorschemes.matugen-nvim.opts")
    require("matugen").setup(opts)
  end,
  priority = 1000,
  cond = false,
  enabled = false,
}

return spec
