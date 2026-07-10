-- Custom colors override highlight_group:
---@type CamouflageColorsConfig | nil
local colors = {
  -- Foreground color (hex or color name, nil to use highlight_group)
  ---@type string | nil
  foreground = "#808080",

  -- Background color (hex, color name, 'transparent', or nil)
  ---@type string | nil
  background = "transparent",

  -- Bold text
  ---@type boolean | nil
  bold = false,

  -- Italic text
  ---@type boolean | nil
  italic = false,
}

colors = nil

return colors
