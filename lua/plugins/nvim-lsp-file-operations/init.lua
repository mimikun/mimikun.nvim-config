---@type LazySpec
local spec = {
  "antosha417/nvim-lsp-file-operations",
  --lazy = false,
  event = require("plugins.nvim-lsp-file-operations.events"),
  dependencies = require("plugins.nvim-lsp-file-operations.dependencies"),
  --opts = require("plugins.nvim-lsp-file-operations.opts"),
  config = function()
    local opts = require("plugins.nvim-lsp-file-operations.opts")
    require("lsp-file-operations").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
