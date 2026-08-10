---@type blink.cmp.AppearanceConfig
local appearance = {
  -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  ---@type boolean
  use_nvim_cmp_as_default = false,

  -- 'mono' for 'Nerd Font Mono', 'normal' for 'Nerd Font'
  ---@type "mono" | "normal"
  nerd_font_variant = "mono",
}

return appearance
