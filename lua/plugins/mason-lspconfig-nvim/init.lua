---@type LazySpec
local spec = {
  "mason-org/mason-lspconfig.nvim",
  --lazy = false,
  cmd = require("plugins.mason-lspconfig-nvim.cmds"),
  event = require("plugins.mason-lspconfig-nvim.events"),
  dependencies = require("plugins.mason-lspconfig-nvim.dependencies"),
  --opts = require("plugins.mason-lspconfig-nvim.opts"),
  config = function()
    local opts = require("plugins.mason-lspconfig-nvim.opts")
    require("mason-lspconfig").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
