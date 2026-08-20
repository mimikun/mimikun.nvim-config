local input = require("ccc").input

-- List of color system to be activated.
-- |ccc-action-toggle_input_mode| toggles in this order.
-- The first one is the default used at the first startup.
-- Once activated, it will keep the previous input mode.
-- The presets currently available are as follows:
---@type ccc.ColorInput[]
local inputs = {
  -- RGB: ccc.input.rgb
  input.rgb,

  -- HSL: ccc.input.hsl
  input.hsl,

  -- HWB: ccc.input.hwb
  --input.hwb,

  -- Lab: ccc.input.lab
  --input.lab,

  -- LCH: ccc.input.lch
  --input.lch,

  -- OKLab: ccc.input.oklab
  --input.oklab,

  -- OKLCH: ccc.input.oklch
  --input.oklch,

  -- CMYK: ccc.input.cmyk
  input.cmyk,

  -- HSLuv: ccc.input.hsluv
  --input.hsluv,

  -- OKHSL: ccc.input.okhsl
  --input.okhsl,

  -- HSV: ccc.input.hsv
  --input.hsv,

  -- OKHSV: ccc.input.okhsv
  --input.okhsv,

  -- XYZ: ccc.input.xyz
  --input.xyz,
}

return inputs
