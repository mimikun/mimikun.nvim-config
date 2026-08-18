---@type OctoConfigPoll
local poll = {
  -- opt-in polling for remote changes
  ---@type boolean
  enabled = false,

  -- polling interval in milliseconds (default: 10s)
  ---@type number
  interval = 10000,

  -- notify when a buffer is auto-refreshed
  ---@type boolean
  notify_on_refresh = true,

  -- notify when remote changed but buffer has local edits
  ---@type boolean
  notify_on_change = true,
}

return poll
