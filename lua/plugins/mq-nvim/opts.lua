---@type table
local opts = {
  -- Path to mq executable (if not in PATH)
  cmd = "mq",

  -- LSP server arguments
  lsp_args = {
    "lsp",
  },

  -- Show examples when creating new file
  show_examples = true,

  -- Automatically start LSP server
  auto_start_lsp = true,

  -- Enable type checking (passes --enable-type-checking to mq-lsp)
  enable_type_check = true,

  -- Enable strict array mode (passes --strict-array to mq-lsp, requires enable_type_check)
  strict_array = true,

  -- Enable LSP inlay hints (requires Neovim 0.10+)
  enable_inlay_hints = true,

  -- LSP server configuration
  lsp = {
    -- Custom on_attach function
    on_attach = function(client, bufnr)
      -- Your custom on_attach logic
      return nil
    end,

    -- Custom capabilities
    capabilities = nil,

    -- LSP settings
    settings = {},
  },
}

return opts
