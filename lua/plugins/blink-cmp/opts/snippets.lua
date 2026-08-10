---@type blink.cmp.SnippetsConfig
local snippets = {
  -- LuaSnip, so snippets can be written in Lua (function / dynamic / choice
  -- nodes), which the built-in 'default' preset cannot express: it only reads
  -- VSCode-style JSON.
  -- Expansion and tab stop jumping are delegated to LuaSnip, so <Tab> keeps
  -- working inside a snippet.
  ---@type "default" | "luasnip" | "mini_snippets" | "vsnip"
  preset = "luasnip",

  -- Offset to the score of all snippet items
  ---@type integer
  score_offset = -3,
}

return snippets
