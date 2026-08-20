local output = require("ccc").output

-- List of output format to be activated.
-- |ccc-action-toggle_ouotput_mode| toggles in this order.
-- The first one is the default used at the first startup.
-- Once activated, it will keep the previous output mode.
-- The presets currently available are as follows:
---@type ccc.ColorOutput[]
local outputs = {
  -- HEX (6/8 digits): ccc.output.hex
  output.hex,

  -- HEX (3/4 digits): ccc.output.hex_short
  output.hex_short,

  -- CssRGB: ccc.output.css_rgb
  output.css_rgb,

  -- CssRGBA: ccc.output.css_rgba
  --output.css_rgba,

  -- CssHSL: ccc.output.css_hsl
  output.css_hsl,

  -- CssHWB: ccc.output.css_hwb
  --output.css_hwb,

  -- CssLab: ccc.output.css_lab
  --output.css_lab,

  -- CssLCH: ccc.output.css_lch
  --output.css_lch,

  -- CssOKLab: ccc.output.css_oklab
  --output.css_oklab,

  -- CssOKLCH: ccc.output.css_oklch
  --output.css_oklch,

  -- Float: ccc.output.float
  --output.float,
}

return outputs
