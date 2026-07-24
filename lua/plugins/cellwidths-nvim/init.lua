---@type LazySpec
local spec = {
  "delphinus/cellwidths.nvim",
  --lazy = false,
  cmd = require("plugins.cellwidths-nvim.cmds"),
  event = require("plugins.cellwidths-nvim.events"),
  --init = function()
  --  vim.opt.listchars = {
  --    eol = "⏎",
  --  }
  --  vim.opt.fillchars = {
  --    eob = "‣",
  --  }
  --end,
  --opts = require("plugins.cellwidths-nvim.opts"),
  config = function()
    local opts = require("plugins.cellwidths-nvim.opts")
    require("cellwidths").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
