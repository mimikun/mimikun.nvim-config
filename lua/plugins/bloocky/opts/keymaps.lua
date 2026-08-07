local keymaps = {
  -- Global
  toggle = "<leader>tb",

  -- Inside the calendar window
  calendar = {
    nav_left = "h",
    nav_down = "j",
    nav_up = "k",
    nav_right = "l",

    -- previous month/week (depends on view)
    prev_period = "H",

    -- next month/week
    next_period = "L",

    view_day = "gd",
    view_week = "gw",
    view_month = "gm",
    cycle_view = "<Tab>",
    today = "t",
    add = "a",
    edit = "<CR>",
    delete = "x",
    close = "q",
  },
}

return keymaps
