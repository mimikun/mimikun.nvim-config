---@type LazySpec
local spec = {
  "mason-org/mason-lspconfig.nvim",
  --lazy = false,
  cmd = require("plugins.mason-lspconfig-nvim.cmds"),
  event = require("plugins.mason-lspconfig-nvim.events"),
  dependencies = require("plugins.mason-lspconfig-nvim.dependencies"),
  opts = require("plugins.mason-lspconfig-nvim.opts"),
  --config = function()
  --    INIT
  --end,
  --cond = false,
  --enabled = false,
}

return spec
