-- phase lengths in minutes
---@type pomodoro.DurationsConfig
local durations = {
  -- work block length in minutes
  ---@type number | 25
  work = 25,

  -- short break length in minutes
  ---@type number | 5
  short_break = 5,

  -- long break length in minutes
  ---@type number | 15
  long_break = 15,
}

return durations
