---@type render.md.dash.Config
local dash = {
  -- Useful context to have when evaluating values.
  -- | width | width of the current window |

  -- Turn on / off thematic break rendering.
  enabled = true,

  -- Additional modes to render dash.
  render_modes = false,

  -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'.
  -- The icon gets repeated across the window's width.
  ---@type string
  icon = "─",

  -- Width of the generated line.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  -- Output is evaluated depending on the type.
  -- function: `value(context)`
  -- number: `value`
  -- full: width of the window
  ---@type render.md.dash.Width
  width = "full",

  -- Amount of margin to add to the left of dash.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  ---@type number
  left_margin = 0,

  -- Priority to assign to dash.
  ---@type integer
  priority = nil,

  -- Highlight for the whole line generated from the icon.
  ---@type string
  highlight = "RenderMarkdownDash",
}

return dash
