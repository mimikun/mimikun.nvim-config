---@type crates.UserCompletionConfig
local completion = {
  ---@type boolean
  insert_closing_quote = true,

  ---@type crates.UserCompletionTextConfig
  text = require("plugins.crates-nvim.opts.completion.text"),

  ---@type crates.UserCmpConfig
  cmp = {
    ---@type boolean
    enabled = false,

    ---@type boolean
    use_custom_kind = true,

    ---@type crates.UserCmpKindTextConfig
    kind_text = {
      ---@type string
      version = "Version",

      ---@type string
      feature = "Feature",
    },

    ---@type crates.UserCmpKindHighlightConfig
    kind_highlight = {
      ---@type string
      version = "CmpItemKindVersion",

      ---@type string
      feature = "CmpItemKindFeature",
    },
  },

  ---@type crates.UserCoqConfig
  coq = {
    ---@type boolean
    enabled = false,

    ---@type string
    name = "crates.nvim",
  },

  ---@type crates.UserBlinkConfig
  blink = {
    ---@type boolean
    use_custom_kind = true,

    ---@type crates.UserBlinkKindTextConfig
    kind_text = {
      ---@type string
      version = "Version",

      ---@type string
      feature = "Feature",
    },

    ---@type crates.UserBlinkKindHighlightConfig
    kind_highlight = {
      ---@type string
      version = "BlinkCmpKindVersion",

      ---@type string
      feature = "BlinkCmpKindFeature",
    },

    ---@type crates.UserBlinkKindIconConfig
    kind_icon = {
      ---@type string
      version = " ",

      ---@type string
      feature = " ",
    },
  },

  ---@type crates.UserCrateCompletionConfig
  crates = {
    -- Disabled by default
    ---@type boolean
    enabled = true,

    -- The maximum number of search results to display
    ---@type integer
    max_results = 8,

    -- The minimum number of charaters to type before completions begin appearing
    ---@type integer
    min_chars = 3,
  },
}

return completion
