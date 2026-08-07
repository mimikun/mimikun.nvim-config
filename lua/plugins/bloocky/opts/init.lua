---@type table
local opts = {
  -- Where time blocks are persisted
  save_path = vim.fn.stdpath("data") .. "/bloocky_blocks.json",

  -- View shown when the calendar opens: "day" | "week" | "month"
  ---@type string | "day" | "week" | "month"
  default_view = "week",

  -- First day of the week: "sunday" | "monday"
  ---@type string | "sunday" | "monday"
  week_start = "sunday",

  -- Visible hour range in the day and week views
  hours = require("plugins.bloocky.opts.hours"),

  -- Block start/duration are snapped to this many minutes
  granularity = 30,

  window = require("plugins.bloocky.opts.window"),

  icons = require("plugins.bloocky.opts.icons"),

  -- Bring tasks from other plugins into the calendar
  integrations = require("plugins.bloocky.opts.integrations"),

  keymaps = require("plugins.bloocky.opts.keymaps"),
}

return opts
