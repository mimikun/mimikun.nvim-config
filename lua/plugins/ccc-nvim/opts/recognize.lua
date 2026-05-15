local input = require("ccc").input
local output = require("ccc").output
local picker = require("ccc").picker

local recognize = {
  input = false,
  output = false,
  pattern = {
    [picker.css_rgb] = { input.rgb, output.css_rgb },
    [picker.css_name] = { input.rgb, output.css_rgb },
    [picker.hex] = { input.rgb, output.hex },
    [picker.hex_long] = { input.rgb, output.hex },
    [picker.hex_short] = { input.rgb, output.hex_short },
    [picker.css_hsl] = { input.hsl, output.css_hsl },
    [picker.css_hwb] = { input.hwb, output.css_hwb },
    [picker.css_lab] = { input.lab, output.css_lab },
    [picker.css_lch] = { input.lch, output.css_lch },
    [picker.css_oklab] = { input.oklab, output.css_oklab },
    [picker.css_oklch] = { input.oklch, output.css_oklch },
  },
}

return recognize
