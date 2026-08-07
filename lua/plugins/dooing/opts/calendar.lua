local calendar = {
  language = "en",
  ---@type string | "sunday" | "monday"
  start_day = "sunday",

  icon = "",
  keymaps = {
    previous_day = "h",
    next_day = "l",
    previous_week = "k",
    next_week = "j",
    previous_month = "H",
    next_month = "L",
    select_day = "<CR>",
    close_calendar = "q",
  },
}

return calendar
