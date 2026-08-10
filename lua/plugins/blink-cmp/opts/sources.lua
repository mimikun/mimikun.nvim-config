---@type blink.cmp.SourceConfig
local sources = {
  -- Providers enabled by default.
  -- 'lsp' stays listed even though capabilities are not wired up yet: it simply
  -- returns nothing until then, and 'path' / 'buffer' already fill the menu.
  ---@type blink.cmp.SourceList
  default = {
    "lsp",
    "path",
    "snippets",
    "buffer",
  },

  -- Minimum number of characters in the keyword to trigger
  ---@type integer | fun(ctx: blink.cmp.Context): integer
  min_keyword_length = 0,
}

return sources
