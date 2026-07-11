---@type pomodoro.SoundConfig
local sound = {
  -- play a sound on natural phase end
  ---@type boolean | false
  enabled = false,

  -- command string (run via `sh -c`) or argv table;
  -- nil uses `afplay` with a system sound on macOS
  -- Opt-in sound on phase end (not played on skip)
  ---@type string | string[] | nil
  cmd = nil,
}

return sound
