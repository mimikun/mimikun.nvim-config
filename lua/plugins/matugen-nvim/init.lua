---@type LazySpec
local spec = {
  "daedlock/matugen.nvim",
  lazy = false,
  cmd = require("plugins.matugen-nvim.cmds"),
  event = require("plugins.matugen-nvim.events"),
  --opts = require("plugins.matugen-nvim.opts"),
  config = function()
    local opts = require("plugins.matugen-nvim.opts")
    require("matugen").setup(opts)
    --vim.cmd.colorscheme("matugen")
  end,
  priority = 1000,
  --cond = false,
  --enabled = false,
}

return spec
