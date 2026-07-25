---@type LazySpec
local spec = {
  "mason-org/mason-lspconfig.nvim",
  --lazy = false,
  cmd = require("plugins.mason-lspconfig-nvim.cmds"),
  event = require("plugins.mason-lspconfig-nvim.events"),
  dependencies = require("plugins.mason-lspconfig-nvim.dependencies"),
  --opts = require("plugins.mason-lspconfig-nvim.opts"),
  config = function()
    -- Narrow the filetypes of noisy servers before mason-lspconfig enables them.
    -- `vim.lsp.config()` replaces list fields wholesale instead of
    -- merging them, so filter the upstream default rather than re-listing every
    -- surviving filetype by hand -- that list would silently go stale.
    local exclude_filetypes = require("plugins.mason-lspconfig-nvim.opts.exclude_filetypes")
    for server, excluded in pairs(exclude_filetypes) do
      local config = vim.lsp.config[server]
      if config and config.filetypes then
        vim.lsp.config(server, {
          filetypes = vim.tbl_filter(function(ft)
            return not vim.list_contains(excluded, ft)
          end, config.filetypes),
        })
      end
    end

    local opts = require("plugins.mason-lspconfig-nvim.opts")
    require("mason-lspconfig").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
