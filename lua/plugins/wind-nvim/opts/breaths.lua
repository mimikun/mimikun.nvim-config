---@type WindBreathsConfig
local breaths = {
  -- Maximum held breaths (1-9, never above 9)
  ---@type integer
  max = 9,

  -- Hold breath 1 from the initial layout
  ---@type boolean
  auto_hold_first = true,

  -- Save breaths per project and load them at startup
  ---@type boolean
  persist = true,

  -- Start every session with no breaths
  ---@type boolean
  clear_on_start = false,
}

return breaths
