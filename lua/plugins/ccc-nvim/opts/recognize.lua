local ccc = require("ccc")
local picker = ccc.picker
local input = ccc.input
local output = ccc.output

-- These are settings for recognize color format.
---@type ccc.Option.recognize
local recognize = {
  -- If true, doing |:CccPick|, it recognizes the color format and automatically adjusts the input to it.
  -- If that format is not registered in |ccc-option-inputs|, it will fall back to the first one.
  ---@type boolean
  input = false,

  -- If true, doing |:CccPick|, it recognizes the color format and automatically adjusts the output to it.
  -- If that format is not registered in |ccc-option-outputs|, it will fall back to the first one.
  ---@type boolean
  output = false,

  -- Define the correspondence between the picker and input, output.
  ---@type table<ccc.ColorPicker, { [1]: ccc.ColorInput, [2]: ccc.ColorOutput }>
  pattern = {
    [picker.css_rgb] = {
      input.rgb,
      output.css_rgb,
    },

    [picker.css_name] = {
      input.rgb,
      output.css_rgb,
    },

    [picker.hex] = {
      input.rgb,
      output.hex,
    },

    [picker.hex_long] = {
      input.rgb,
      output.hex,
    },

    [picker.hex_short] = {
      input.rgb,
      output.hex_short,
    },

    [picker.css_hsl] = {
      input.hsl,
      output.css_hsl,
    },

    [picker.css_hwb] = {
      input.hwb,
      output.css_hwb,
    },

    [picker.css_lab] = {
      input.lab,
      output.css_lab,
    },

    [picker.css_lch] = {
      input.lch,
      output.css_lch,
    },

    [picker.css_oklab] = {
      input.oklab,
      output.css_oklab,
    },

    [picker.css_oklch] = {
      input.oklch,
      output.css_oklch,
    },
  },
}

return recognize
