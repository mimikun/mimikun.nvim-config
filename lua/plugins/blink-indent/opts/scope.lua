---@type blink.indent.ScopeConfig
local scope = {
  -- Highlights highest level of indentation on the current line
  ---@type boolean
  enabled = true,

  -- Clamp to indent level of cursor
  ---@type boolean
  indent_at_cursor = false,

  -- Character used to draw the scope guides
  ---@type string | "┆" | "┊" | "╎" | "║" | "▏" | "▎"
  char = "▎",

  -- Priority of the extmarks used to draw the scope guides
  ---@type integer
  priority = 1000,

  -- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
  -- Highlight groups used to draw the scope guides
  ---@type string[]
  highlights = {
    --"BlinkIndentScope",
    --"BlinkIndentRed",
    "BlinkIndentOrange",
    --"BlinkIndentYellow",
    --"BlinkIndentGreen",
    "BlinkIndentViolet",
    --"BlinkIndentCyan",
    "BlinkIndentBlue",
  },

  -- enable to show underlines on the line above the current scope
  ---@type blink.indent.ScopeUnderlineConfig
  underline = {
    ---@type boolean
    enabled = false,

    -- optionally add: 'BlinkIndentRedUnderline', 'BlinkIndentCyanUnderline', 'BlinkIndentYellowUnderline', 'BlinkIndentGreenUnderline'
    ---@type string[]
    highlights = {
      --"BlinkIndentRedUnderline",
      "BlinkIndentOrangeUnderline",
      --"BlinkIndentYellowUnderline",
      --"BlinkIndentGreenUnderline",
      "BlinkIndentVioletUnderline",
      --"BlinkIndentCyanUnderline",
      "BlinkIndentBlueUnderline",
    },
  },
}

return scope
