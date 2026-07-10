-- Reveal configuration
---@type CamouflageRevealConfig | nil
local reveal = {
  -- Highlight group for revealed values
  ---@type string
  highlight_group = "CamouflageRevealed",

  -- Show notification on reveal/hide
  ---@type boolean
  notify = false,

  -- Set true to auto-reveal current line
  -- Auto-reveal current line as cursor moves
  ---@type boolean | false
  follow_cursor = false,
}

return reveal
