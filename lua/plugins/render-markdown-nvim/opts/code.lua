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
  --   center: center of code block
  --   right: right of code block
  --   left: left of code block
  ---@type render.md.code.Position | string | "center" | "right" | "left"
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
  ---@type string[]
  disable = {},

  -- A list of language names for which background highlighting will be disabled.
  -- Likely because that language has background highlights itself.
  -- Use a boolean to make behavior apply to all languages.
  -- Borders above & below blocks will continue to be rendered.
  ---@type boolean | string[]
  disable_background = {
    "diff",
  },

  -- Number of lines from start/end to skip rendering background.
  ---@type integer
  background_inset = 1,

  -- Width of the code block background.
  --   block: width of the code block
  --   full: full width of the window
  ---@type render.md.code.Width | string | "block" | "full"
  width = "full",

  -- Amount of margin to add to the left of code blocks.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  -- Margin available space is computed after accounting for padding.
  ---@type number
  left_margin = 0,

  -- Amount of padding to add to the left of code blocks.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  ---@type number
  left_pad = 0,

  -- Amount of padding to add to the right of code blocks when width is 'block'.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  ---@type number
  right_pad = 0,

  -- Minimum width to use for code blocks when width is 'block'.
  ---@type integer
  min_width = 0,

  -- Determines how the top / bottom of code block are rendered.
  --   none: do not render a border
  --   thick: use the same highlight as the code body
  --   thin: when lines are empty overlay the above & below icons
  --   hide: conceal lines unless language name or icon is added
  ---@type render.md.code.Border | string | "none" | "thick" | "thin" | "hide"
  border = "hide",

  -- Used above code blocks to fill remaining space around language.
  ---@type string
  language_border = "█",
  --language_border = " ",

  -- Added to the left of language.
  ---@type string
  language_left = "",
  --language_left = "",

  -- Added to the right of language.
  ---@type string
  language_right = "",
  --language_right = "",

  -- Used above code blocks for thin border.
  ---@type string
  above = "▄",

  -- Used below code blocks for thin border.
  ---@type string
  below = "▀",

  -- Turn on / off inline code related rendering.
  ---@type boolean
  inline = true,

  -- Icon to add to the left of inline code.
  ---@type string
  inline_left = "",

  -- Icon to add to the right of inline code.
  ---@type string
  inline_right = "",

  -- Padding to add to the left & right of inline code.
  ---@type integer
  inline_pad = 0,

  -- Priority to assign to code background highlight.
  ---@type integer
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
  ---@type false | string
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
  --   none: { enabled = false }
  --   normal: { language = false }
  --   language: { disable_background = true, inline = false }
  --   full: uses all default values
  ---@type render.md.code.Style | string | "none" | "normal" | "language" | "full"
  style = "full",
}

return code
