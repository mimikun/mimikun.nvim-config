---@type pomo.Config
local opts = {
  -- How often the notifiers are updated.
  ---@type integer
  update_interval = 1000,

  -- Configure the default notifiers to use for each timer.
  -- You can also configure different notifiers for timers given specific names, see the 'timers' field below.
  ---@type pomo.NotifierConfig[]
  notifiers = require("plugins.pomo-nvim.opts.notifiers"),

  -- Override the notifiers for specific timer names.
  ---@type table<string, pomo.NotifierConfig[]>
  timers = require("plugins.pomo-nvim.opts.timers"),

  -- You can optionally define custom timer sessions.
  -- Add sessions field
  ---@type table<string, pomo.SessionConfig[]>
  sessions = require("plugins.pomo-nvim.opts.sessions"),
}

return opts
