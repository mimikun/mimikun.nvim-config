local output = require("ccc").output
local picker = require("ccc").picker

local convert = {
  { picker.hex, output.css_rgb },
  { picker.css_rgb, output.css_hsl },
  { picker.css_hsl, output.hex },
}

return convert
