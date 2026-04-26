-- Override the notifiers for specific timer names.
---@type table<string, pomo.NotifierConfig[]>
local timers = {
  -- For example, use only the "System" notifier when you create a timer called "Break",
  -- e.g. ':TimerStart 2m Break'.
  Break = {
    {
      name = "System",
    },
  },
}

return timers
