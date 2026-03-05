---@type LazySpec
local spec = {
  "neovim/nvim-lspconfig",
  --lazy = false,
  cmd = require("plugins.nvim-lspconfig.cmds"),
  event = require("plugins.nvim-lspconfig.events"),
  --cond = false,
  --enabled = false,
}

return spec
