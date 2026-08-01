---@type LazySpec
local spec = {
  "catppuccin/nvim",
  name = "catppuccin",
  --lazy = false,
  --cmd = require("colorschemes.catppuccin-nvim.cmds"),
  --keys = require("colorschemes.catppuccin-nvim.keys"),
  --event = require("colorschemes.catppuccin-nvim.events"),
  --dependencies = require("colorschemes.catppuccin-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("colorschemes.catppuccin-nvim.opts"),
  config = function()
    local opts = require("colorschemes.catppuccin-nvim.opts")
    require("catppuccin").setup(opts)
    --vim.cmd.colorscheme("catppuccin-nvim")
  end,
  priority = 1000,
  cond = false,
  enabled = false,
}

return spec
