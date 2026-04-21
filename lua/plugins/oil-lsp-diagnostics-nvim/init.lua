---@type LazySpec
local spec = {
  "JezerM/oil-lsp-diagnostics.nvim",
  lazy = false,
  dependencies = require("plugins.oil-lsp-diagnostics-nvim.dependencies"),
  opts = require("plugins.oil-lsp-diagnostics-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
