---@type rustowl.Config
local opts = {
  -- Whether to auto-attach the LSP client when opening a Rust file.
  ---@type boolean | true
  auto_attach = true,

  -- Enable RustOwl immediately on LspAttach
  ---@type boolean
  auto_enable = false,

  -- Time in milliseconds to hover with the cursor before triggering RustOwl
  ---@type number
  idle_time = 300,

  -- The highlight style to use for underlines ('undercurl' or 'underline')
  ---@type rustowl.HighlightStyles
  highlight_styles = require("plugins.rustowl.opts.highlight_styles"),

  -- Custom colors for different highlight types
  ---@type rustowl.Colors
  colors = require("plugins.rustowl.opts.colors"),

  -- The LSP client config (This can also be set using |vim.lsp.config()|).
  ---@type rustowl.ClientConfig
  client = require("plugins.rustowl.opts.client"),
}

return opts
