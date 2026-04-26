-- You can optionally define custom timer sessions.
-- Add sessions field
---@type table<string, pomo.SessionConfig[]>
local sessions = {
  -- Example session configuration for a session called "pomodoro".
  pomodoro = {
    {
      name = "Work",
      duration = "25m",
    },
    {
      name = "Short Break",
      duration = "5m",
    },
    {
      name = "Work",
      duration = "25m",
    },
    {
      name = "Short Break",
      duration = "5m",
    },
    {
      name = "Work",
      duration = "25m",
    },
    {
      name = "Long Break",
      duration = "15m",
    },
  },
}

return sessions
