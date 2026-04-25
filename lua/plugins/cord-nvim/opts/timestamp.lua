-- Timestamp configuration
---@type CordTimestampConfig
local timestamp = {
  -- Whether timestamps are enabled
  ---@type boolean
  enabled = true,

  -- Whether to reset timestamp when idle
  ---@type boolean
  reset_on_idle = false,

  -- Whether to reset timestamp when changing activities
  ---@type boolean
  reset_on_change = false,

  -- Whether to share timestamps between clients
  ---@type boolean
  shared = false,
}

return timestamp
