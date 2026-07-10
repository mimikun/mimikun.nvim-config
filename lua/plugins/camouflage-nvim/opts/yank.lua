-- Yank configuration
---@type CamouflageYankConfig | nil
local yank = {
  ---Default register ('+' for system clipboard)
  ---@type string
  default_register = "+",

  ---Show notification after copy
  ---@type boolean
  notify = true,

  -- Auto-clear clipboard
  ---Seconds before auto-clearing clipboard (nil = disabled)
  ---@type number | nil
  auto_clear_seconds = 30,

  -- Require confirmation before copying
  ---@type boolean
  confirm = true,

  -- Confirmation message format
  ---@type string
  confirm_message = 'Copy value of "%s" to clipboard?',
}

return yank
