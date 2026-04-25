-- Display configuration
---@type CordDisplayConfig
local display = {
  -- Set icon theme
  ---@type string | "default" | "atom" | "catppuccin" | "minecraft" | "void" | "classic"
  theme = "default",

  ---Set icon theme flavor
  ---@type string | "dark" | "light" | "accent"
  flavor = "dark",

  ---@type string | "full" | "editor" | "asset" | "auto"
  ---Control what shows up as the large and small images
  view = "full",

  -- Whether to swap activity fields
  ---@type boolean
  swap_fields = false,

  -- Whether to swap activity icons
  ---@type boolean
  swap_icons = false,
}

return display
