---@type blink.pairs.HighlightsConfig
local highlights = {
  ---@type boolean
  enabled = true,

  -- Requires `require('vim._extui').enable({})`, otherwise has no effect
  ---@type boolean
  cmdline = true,

  -- Highlight groups for matched pairs, in order that they'll appear based on depth, or a function that returns a highlight group for a given match
  ---@type string[] | fun(match: blink.pairs.Match): string
  groups = {
    -- disable rainbow highlighting
    --"BlinkPairs",
    "BlinkPairsOrange",
    "BlinkPairsPurple",
    "BlinkPairsBlue",
  },

  -- Highlight group for unmatched pairs
  ---@type string
  unmatched_group = "BlinkPairsUnmatched",

  ---@type number
  priority = 200,

  ---@type integer
  ns = vim.api.nvim_create_namespace("blink.pairs"),

  -- highlights matching pairs under the cursor
  ---@type blink.pairs.MatchparenConfig
  matchparen = {
    --- @field enabled boolean
    enabled = true,

    -- Requires `require('vim._extui').enable({})`.
    -- Disabled by default due to only showing matchparen when moving the cursor, and not when typing.
    ---@type boolean
    cmdline = false,

    -- Also include pairs not on top of the cursor, but surrounding the cursor
    ---@type boolean
    include_surrounding = false,

    -- Highlight group for the matching pair
    ---@type string
    group = "BlinkPairsMatchParen",
    --group = "MatchParen",

    -- Priority of the highlight
    ---@type number
    priority = 250,
  },
}

return highlights
