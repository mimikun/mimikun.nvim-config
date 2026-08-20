local picker = require("ccc").picker

-- List of formats that can be detected by |:CccPick| to be activated.
-- The presets currently available are as follows:
---@type ccc.ColorPicker[]
local pickers = {
  picker.hex,
  picker.css_rgb,
  picker.css_hsl,
  picker.css_hwb,
  picker.css_lab,
  picker.css_lch,
  picker.css_oklab,
  picker.css_oklch,
}

return pickers
