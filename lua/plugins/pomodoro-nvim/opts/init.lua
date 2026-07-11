---@type pomodoro.Config
local opts = {
  -- phase lengths in minutes
  ---@type pomodoro.DurationsConfig
  durations = require("plugins.pomodoro-nvim.opts.durations"),

  -- Long break every Nth completed work block
  ---@type number | 4
  cycles_per_long_break = 4,

  -- Target work blocks per day
  ---@type number | 0
  daily_goal = 0,

  -- Phase transition behavior
  -- break begins as soon as work ends
  ---@type boolean | true
  auto_start_break = true,

  -- next work block begins as soon as a break ends
  ---@type boolean | false
  auto_start_work = false,

  -- Notification channels (any subset, in display order)
  notify_styles = {
    "vim_notify",
    "float",
  },

  ---@type pomodoro.NotifyConfig
  notify = {
    -- how long the floating toast stays up
    ---@type number | 4000
    float_duration_ms = 4000,
  },

  ---@type pomodoro.SoundConfig
  sound = require("plugins.pomodoro-nvim.opts.sound"),

  -- Statusline component appearance
  ---@type pomodoro.StatuslineConfig
  statusline = require("plugins.pomodoro-nvim.opts.statusline"),

  -- Toggleable pinned status window (borderless card)
  ---@type pomodoro.StatusWindowConfig
  status_window = require("plugins.pomodoro-nvim.opts.status_window"),

  -- Opt-in focus enforcement
  ---@type pomodoro.FocusConfig
  focus = require("plugins.pomodoro-nvim.opts.focus"),

  -- JSON stats on disk
  ---@type pomodoro.PersistenceConfig
  persistence = require("plugins.pomodoro-nvim.opts.persistence"),

  -- Lifecycle hooks
  ---@type pomodoro.HooksConfig
  hooks = require("plugins.pomodoro-nvim.opts.hooks"),
}

return opts
