-- Opt-in focus enforcement
---@type pomodoro.FocusConfig
local focus = {
  ---@type boolean | false
  enabled = false,

  -- Ex commands to block during work, e.g. { "Lazy" }
  ---@type string[]
  blocked_commands = {
    --"Lazy",
    --"Mason",
    --"Telescope",
  },

  -- hide diagnostic virtual_text during work
  ---@type boolean | false
  silent_diagnostics = false,

  -- dim non-current windows during work
  ---@type boolean | false
  dim_inactive = false,
}

return focus
