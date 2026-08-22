---@type LazySpec
local spec = {
  "windwp/nvim-ts-autotag",
  --lazy = false,
  event = require("plugins.nvim-ts-autotag.events"),
  dependencies = require("plugins.nvim-ts-autotag.dependencies"),
  --opts = require("plugins.nvim-ts-autotag.opts"),
  config = function()
    local opts = require("plugins.nvim-ts-autotag.opts")
    require("nvim-ts-autotag").setup(opts)

    -- Enable update on insert
    -- If you have that issue: https://github.com/windwp/nvim-ts-autotag/issues/19

    --vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --  underline = true,
    --  virtual_text = {
    --    spacing = 5,
    --    severity_limit = "Warning",
    --  },
    --  update_in_insert = true,
    --})
  end,
  --cond = false,
  --enabled = false,
}

return spec
