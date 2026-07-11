-- JSON stats on disk
---@type pomodoro.PersistenceConfig
local persistence = {
  -- persist per-day stats as JSON
  ---@type boolean | true
  enabled = true,

  -- nil → vim.fn.stdpath('data') .. '/pomodoro/stats.json'
  ---@type string
  path = nil,
}

return persistence
