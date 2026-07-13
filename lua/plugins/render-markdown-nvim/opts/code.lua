---@type render.md.code.Config
local code = {
  -- Turn on / off code block & inline code rendering.
  enabled = true,

  -- Additional modes to render code blocks.
  render_modes = false,

  -- Turn on / off sign column related rendering.
  ---@type boolean
  sign = true,

  -- Whether to conceal nodes at the top and bottom of code blocks.
  ---@type boolean
  conceal_delimiters = true,

  -- Turn on / off language heading related rendering.
  ---@type boolean
  language = true,

  -- Determines where language icon is rendered.
  -- center: center of code block
  -- right: right of code block
  -- left: left of code block
  ---@type render.md.code.Position
  position = "left",

  -- Whether to include the language icon above code blocks.
  ---@type boolean
  language_icon = true,

  -- Whether to include the language name above code blocks.
  ---@type boolean
  language_name = true,

  -- Whether to include the language info above code blocks.
  ---@type boolean
  language_info = true,

  -- Amount of padding to add around the language.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  ---@type number
  language_pad = 0,

  -- A list of language names for which rendering will be disabled.
  ---@field disable? string[]
  disable = {
    -- TODO: it
  },

  -- A list of language names for which background highlighting will be disabled.
  -- Likely because that language has background highlights itself.
  -- Use a boolean to make behavior apply to all languages.
  -- Borders above & below blocks will continue to be rendered.
  ---@field disable_background? boolean|string[]
  disable_background = {
    "diff",
  },

  -- Number of lines from start/end to skip rendering background.
  ---@field background_inset? integer
  background_inset = 1,

  -- Width of the code block background.
  -- block: width of the code block
  -- full: full width of the window |
  ---@field width? render.md.code.Width
  width = "full",

  -- Amount of margin to add to the left of code blocks.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  -- Margin available space is computed after accounting for padding.
  ---@field left_margin? number
  left_margin = 0,

  -- Amount of padding to add to the left of code blocks.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  ---@field left_pad? number
  left_pad = 0,

  -- Amount of padding to add to the right of code blocks when width is 'block'.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  ---@field right_pad? number
  right_pad = 0,

  -- Minimum width to use for code blocks when width is 'block'.
  ---@field min_width? integer
  min_width = 0,

  -- Determines how the top / bottom of code block are rendered.
  -- none: do not render a border
  -- thick: use the same highlight as the code body
  -- thin: when lines are empty overlay the above & below icons
  -- hide: conceal lines unless language name or icon is added
  ---@field border? render.md.code.Border
  border = "hide",

  -- Used above code blocks to fill remaining space around language.
  ---@field language_border? string
  language_border = "█",

  -- Added to the left of language.
  ---@field language_left? string
  language_left = "",

  -- Added to the right of language.
  ---@field language_right? string
  language_right = "",

  -- Used above code blocks for thin border.
  ---@field above? string
  above = "▄",

  -- Used below code blocks for thin border.
  ---@field below? string
  below = "▀",

  -- Turn on / off inline code related rendering.
  ---@field inline? boolean
  inline = true,

  -- Icon to add to the left of inline code.
  ---@field inline_left? string
  inline_left = "",

  -- Icon to add to the right of inline code.
  ---@field inline_right? string
  inline_right = "",

  -- Padding to add to the left & right of inline code.
  ---@field inline_pad? integer
  inline_pad = 0,

  -- Priority to assign to code background highlight.
  ---@field priority? integer
  priority = 140,

  -- Highlight for code blocks.
  ---@type string
  highlight = "RenderMarkdownCode",

  -- Highlight for code info section, after the language.
  ---@type string
  highlight_info = "RenderMarkdownCodeInfo",

  -- Highlight for language, overrides icon provider value.
  ---@type string
  highlight_language = nil,

  -- Highlight for border, use false to add no highlight.
  ---@type string | boolean | false
  highlight_border = "RenderMarkdownCodeBorder",

  -- Highlight for language, used if icon provider does not have a value.
  ---@type string
  highlight_fallback = "RenderMarkdownCodeFallback",

  -- Highlight for inline code.
  ---@type string
  highlight_inline = "RenderMarkdownCodeInline",

  -- Highlight for inline code left icon, default to reverse of highlight_inline.
  ---@type string
  highlight_inline_left = nil,

  -- Highlight for inline code right icon, default to reverse of highlight_inline.
  ---@type string
  highlight_inline_right = nil,

  -- Determines how code blocks & inline code are rendered.
  -- none: { enabled = false }
  -- normal: { language = false }
  -- language: { disable_background = true, inline = false }
  -- full: uses all default values
  ---@type render.md.code.Style
  style = "full",
}

return code
