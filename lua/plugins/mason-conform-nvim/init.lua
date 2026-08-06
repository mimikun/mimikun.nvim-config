---@type LazySpec
local spec = {
  -- Local checkout while this is being developed. Swap for "mimikun/mason-conform.nvim"
  -- once it is pushed.
  dir = vim.fn.expand("~/ghq/github.com/mimikun/mason-conform.nvim"),
  name = "mason-conform.nvim",
  --lazy = false,
  dependencies = require("plugins.mason-conform-nvim.dependencies"),
  cmd = require("plugins.mason-conform-nvim.cmds"),
  event = require("plugins.mason-conform-nvim.events"),
  --opts = require("plugins.mason-conform-nvim.opts"),
  config = function()
    local opts = require("plugins.mason-conform-nvim.opts")
    require("mason-conform").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
