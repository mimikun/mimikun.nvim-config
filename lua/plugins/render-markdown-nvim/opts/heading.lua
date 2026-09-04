---@type render.md.heading.Config
local heading = {
  -- Useful context to have when evaluating values.
  --   level: the number of '#' in the heading marker
  --   sections: for each level how deeply nested the heading is

  -- Turn on / off heading icon & background rendering.
  enabled = true,

  -- Additional modes to render headings.
  render_modes = false,

  -- Turn on / off atx heading rendering.
  ---@type boolean
  atx = true,

  -- Turn on / off setext heading rendering.
  ---@type boolean
  setext = true,

  -- Turn on / off sign column related rendering.
  ---@type boolean
  sign = true,

  -- Replaces '#+' of 'atx_h._marker'.
  -- Output is evaluated depending on the type.
  --  function: `value(context)`
  --  string[]: `cycle(value, context.level)`
  ---@type render.md.heading.String | string[] | fun(ctx: render.md.heading.Context): string?
  icons = {
    "󰲡 ",
    --"󰼏 ",
    "󰲣 ",
    --"󰎨 ",
    "󰲥 ",
    "󰲧 ",
    "󰲩 ",
    "󰲫 ",
  },

  -- Determines how icons fill the available space.
  --   eol: '#'s are concealed and icon is placed at right most column
  --   right: '#'s are concealed and icon is appended to right side
  --   inline: '#'s are concealed and icon is inlined on left side
  --   overlay: icon is left padded with spaces and overlayed hiding all '#'
  ---@type render.md.heading.Position | string | "eol" | "right" | "inline" | "overlay"
  position = "overlay",

  -- Added to the sign column if enabled.
  -- Output is evaluated by `cycle(value, context.level)`.
  ---@type string[]
  signs = {
    "󰫎 ",
  },

  -- Width of the heading background.
  --   block: width of the heading text
  --   full: full width of the window
  -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
  ---@type render.md.heading.Width | (render.md.heading.Width)[]
  width = "full",
  --width = {
  --  "full",
  --  "block",
  --  "full",
  --  "block",
  --},

  -- Amount of margin to add to the left of headings.
  -- Margin available space is computed after accounting for padding.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
  ---@type number | number[]
  left_margin = 0,

  -- Amount of padding to add to the left of headings.
  -- Output is evaluated using the same logic as 'left_margin'.
  ---@type number | number[]
  left_pad = 0,

  -- Amount of padding to add to the right of headings when width is 'block'.
  -- Output is evaluated using the same logic as 'left_margin'.
  ---@type number | number[]
  right_pad = 0,

  -- Minimum width to use for headings when width is 'block'.
  -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
  ---@type integer | integer[]
  min_width = 0,

  -- Determines if a border is added above and below headings.
  -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
  ---@type boolean | boolean[]
  border = false,

  -- Always use virtual lines for heading borders instead of attempting to use empty lines.
  ---@type boolean
  border_virtual = false,

  -- Highlight the start of the border using the foreground highlight.
  ---@type boolean
  border_prefix = false,

  -- Used above heading for border.
  ---@type string
  above = "▄",

  -- Used below heading for border.
  ---@type string
  below = "▀",

  -- Highlight for the heading icon and extends through the entire line.
  -- Output is evaluated by `clamp(value, context.level)`.
  ---@type string[]
  backgrounds = {
    "RenderMarkdownH1Bg",
    "RenderMarkdownH2Bg",
    "RenderMarkdownH3Bg",
    "RenderMarkdownH4Bg",
    "RenderMarkdownH5Bg",
    "RenderMarkdownH6Bg",
  },

  -- Highlight for the heading and sign icons.
  -- Output is evaluated using the same logic as 'backgrounds'.
  ---@type string[]
  foregrounds = {
    "RenderMarkdownH1",
    "RenderMarkdownH2",
    "RenderMarkdownH3",
    "RenderMarkdownH4",
    "RenderMarkdownH5",
    "RenderMarkdownH6",
  },

  -- Define custom heading patterns which allow you to override various properties based on
  -- the contents of a heading.
  -- The key is for healthcheck and to allow users to change its values, value type below.
  --   pattern: matched against the heading text @see :h lua-patterns
  --   icon: optional override for the icon
  --   background: optional override for the background
  --   foreground: optional override for the foreground
  ---@type table<string, render.md.heading.Custom>
  custom = {},
}

return heading
