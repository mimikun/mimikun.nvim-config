-- Statusline component appearance
---@type pomodoro.StatuslineConfig
local statusline = {
  -- prefix icon
  ---@type string | ""
  icon = "",

  -- render the component while idle
  ---@type boolean | false
  show_when_idle = false,

  -- `string.format` pattern receiving icon, body
  ---@type string | "%s %s"
  format = "%s %s",

  -- live tick while a phase is running
  -- statusline redraw interval while running
  ---@type number | 250
  refresh_ms = 250,

  -- function(ctx) return boolean end
  -- return false to hide the component
  ---@type fun(ctx: { phase: string, remaining_ms: number }): boolean
  condition = nil,
}

return statusline
