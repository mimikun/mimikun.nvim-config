-- LSP server configuration
---@type IWE.Config.LSP
local lsp = {
  -- Command to start the LSP server
  ---@type string[]
  cmd = {
    "iwes",
  },

  -- Name of the LSP server
  ---@type string
  name = "iwes",

  -- Debounce time for text changes
  ---@type number
  debounce_text_changes = 500,

  -- Whether to format on save
  ---@type boolean
  auto_format_on_save = true,

  -- Whether to enable inlay hints
  ---@type boolean
  enable_inlay_hints = true,

  -- Whether to enable LSP-based folding
  ---@type boolean
  enable_folding = true,
}

return lsp
