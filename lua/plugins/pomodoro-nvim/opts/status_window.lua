-- Toggleable pinned status window (borderless card)
---@type pomodoro.StatusWindowConfig
local status_window = {
  ---@type string | string[] | "none"
  border = "none",

  ---@type number | 36
  width = 36,

  ---@type number | 5
  height = 5,

  ---@type string | "NE"
  anchor = "NE",

  ---@type number | 1
  row = 1,

  ---@type number | 2
  col_offset = 2,

  ---@type number | 250
  refresh_ms = 250,

  ---@type boolean | true
  show_progress_bar = true,

  ---@type boolean | true
  show_today = true,

  -- optional float title, e.g. " pomodoro "
  ---@type string | nil
  title = nil,

  -- title position when title is set
  ---@type string | "left" | "center" | "right"
  title_pos = "center",

  ---@type pomodoro.StatusWindowIcons
  icons = {
    ---@type string
    work = "▶",

    ---@type string
    short_break = "•",

    ---@type string
    long_break = "★",

    ---@type string
    paused = "❚❚",

    ---@type string
    idle = "○",
  },
}

return status_window
