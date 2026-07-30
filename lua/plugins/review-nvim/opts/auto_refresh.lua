---@type ReviewAutoRefreshConfig
local auto_refresh = {
  -- Whether to auto-refresh on file changes
  ---@type boolean
  enabled = true,

  -- Debounce interval in milliseconds
  ---@type number
  debounce_ms = 500,
}

return auto_refresh
