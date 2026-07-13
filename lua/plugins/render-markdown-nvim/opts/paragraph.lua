---@type render.md.paragraph.Config
local paragraph = {
  -- Useful context to have when evaluating values.
  -- text: text value of the node

  -- Turn on / off paragraph rendering.
  enabled = true,

  -- Additional modes to render paragraphs.
  render_modes = false,

  -- Amount of margin to add to the left of paragraphs.
  -- If a float < 1 is provided it is treated as a percentage of available window space.
  -- Output is evaluated depending on the type.
  -- function: `value(context)`
  -- number: `value`
  ---@field left_margin? render.md.paragraph.Number
  left_margin = 0,

  -- Amount of padding to add to the first line of each paragraph.
  -- Output is evaluated using the same logic as 'left_margin'.
  ---@field indent? render.md.paragraph.Number
  indent = 0,

  -- Minimum width to use for paragraphs.
  ---@field min_width? integer
  min_width = 0,
}

return paragraph
