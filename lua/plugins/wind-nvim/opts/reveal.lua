---@type WindRevealConfig
local reveal = {
  ---@type boolean
  enabled = true,

  -- Hesitation before guidance appears in a dispatch loop (0 = instant)
  ---@type integer
  delay_ms = 150,

  -- Gust stagger and vapor fades
  ---@type boolean
  animate = true,
}

return reveal
