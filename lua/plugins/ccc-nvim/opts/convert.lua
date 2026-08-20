local ccc = require("ccc")
local picker = ccc.picker
local output = ccc.output

-- Specify the correspondence between picker and output.
-- The default setting converts the color to css_rgb if it is in hex format, to css_hsl if it is in css_rgb format, and to hex if it is in css_hsl format.
---@type { [1]: ccc.ColorPicker, [2]: ccc.ColorOutput }[]
local convert = {
  {
    picker.hex,
    output.css_rgb,
  },
  {
    picker.css_rgb,
    output.css_hsl,
  },
  {
    picker.css_hsl,
    output.hex,
  },
}

return convert
