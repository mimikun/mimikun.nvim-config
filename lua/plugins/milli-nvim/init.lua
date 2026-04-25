---@type LazySpec
local spec = {
  "amansingh-afk/milli.nvim",
  lazy = false,
  cmd = require("plugins.milli-nvim.cmds"),
  event = require("plugins.milli-nvim.events"),
  init = function()
    vim.opt.termguicolors = true
  end,
  --cond = false,
  --enabled = false,
}

return spec
