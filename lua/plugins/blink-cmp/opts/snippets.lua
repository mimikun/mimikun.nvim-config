---@type blink.cmp.SnippetsConfig
local snippets = {
  -- 'default' uses the built-in source, which expands through `vim.snippet`
  -- and reads `stdpath("config") .. "/snippets"` (this repository's snippets/)
  -- with no extra configuration.
  -- Switch to 'luasnip' / 'mini_snippets' / 'vsnip' if a dedicated engine is added.
  ---@type "default" | "luasnip" | "mini_snippets" | "vsnip"
  preset = "default",

  -- Offset to the score of all snippet items
  ---@type integer
  score_offset = -3,
}

return snippets
