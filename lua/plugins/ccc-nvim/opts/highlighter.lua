-- These are settings for CccHighlighter.
---@type ccc.Option.highlighter
local highlighter = {
  -- Whether to enable automatically on BufEnter.
  ---@type boolean
  auto_enable = false,

  -- The maximum buffer size for which highlight is enabled by |ccc-option-highlighter-auto-enable|.
  -- 100 KB
  ---@type integer
  max_byte = 100 * 1024,

  -- File types for which highlighting is enabled.
  -- It is only used for automatic highlighting by |ccc-option-highlighter-auto-enable|, and is ignored for manual activation.
  -- An empty table means all file types.
  ---@type string[]
  filetypes = {},

  -- Used only when |ccc-option-highlighter-filetypes| is empty table.
  -- You can specify file types to be excludes.
  ---@type string[]
  excludes = {},

  -- If true, highlight using nvim-lsp.
  -- If LS with the color provider is not attached to a buffer, it falls back to highlight with pickers.
  -- See also |ccc-option-lsp|.
  ---@type boolean
  lsp = true,

  ---@type boolean
  picker = true,

  -- If true, highlights will be updated during insert mode. If false,
  -- highlights will not be updated during editing in insert mode , but
  -- will be updated on |InsertLeave|.
  ---@type boolean
  update_insert = true,
}

return highlighter
