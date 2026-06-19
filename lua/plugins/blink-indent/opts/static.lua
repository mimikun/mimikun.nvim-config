---@type blink.indent.StaticConfig
local static = {
  ---@type boolean
  enabled = true,

  -- Character used to draw the scope guides
  ---@type string | "┆" | "┊" | "╎" | "║" | "▏" | "▎"
  char = "▎",

  -- Character used to draw the whitespace guides.
  -- When `nil` (default), uses the value of `vim.opt.listchars:get().space` (see `:h listchars`)
  ---@type string| nil | "·" | "␣"
  whitespace_char = nil,

  ---@type integer
  priority = 1,

  -- specify multiple highlights here for rainbow-style indent guides
  ---@type string[]
  highlights = {
    "BlinkIndent",
    --"BlinkIndentRed",
    --"BlinkIndentOrange",
    --"BlinkIndentYellow",
    --"BlinkIndentGreen",
    --"BlinkIndentViolet",
    --"BlinkIndentCyan",
  },
}

return static
