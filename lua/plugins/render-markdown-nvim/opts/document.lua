---@type render.md.document.Config
local document = {
  -- Turn on / off document rendering.
  enabled = true,

  -- Additional modes to render document.
  render_modes = false,

  -- Ability to conceal arbitrary ranges of text based on lua patterns, @see :h lua-patterns.
  -- Relies entirely on user to set patterns that handle their edge cases.
  ---@type render.md.document.conceal.Config
  conceal = {
    -- Matched ranges will be concealed using character level conceal.
    ---@type string[]
    char_patterns = {},

    -- Matched ranges will be concealed using line level conceal.
    ---@type string[]
    line_patterns = {},
  },
}

return document
