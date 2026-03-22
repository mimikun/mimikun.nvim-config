---@type LazySpec
local spec = {
  "renerocksai/calendar-vim",
  --lazy = false,
  cmd = require("plugins.calendar-vim.cmds"),
  --keys = require("plugins.calendar-vim.keys"),
  --event = require("plugins.calendar-vim.events"),
  init = function()
    -- Disable standard mappings
    vim.g.calendar_no_mappings = 0

    -- Keeps focus when moving to next or previous calendar
    vim.g.calendar_focus_today = 1

    -- To change the key bindings in the calendar window, add entries to this dictionary.
    -- Possible keys, the action bound to the keycode given in the respective value for this key and the default binding are listed below.
    vim.g.calendar_keys = {
      -- Closes calendar window.
      close = "q",

      -- Executes |calendar_action|.
      do_action = "<CR>",

      -- Executes |calendar_today|.
      goto_today = "t",

      -- Displays a short help message.
      show_help = "?",

      -- Redraws calendar window.
      redisplay = "r",
      -- Jumps to the next month.

      --goto_next_month = "<C-Right>",
      goto_next_month = "<Right>",

      -- Jumps to the previous month.
      --goto_prev_month = "<C-Left>",
      goto_prev_month = "<Left>",

      -- Jumps to the next year.
      goto_next_year = "<Up>",

      -- Jumps to the previous year.
      goto_prev_year = "<Down>",
    }

    -- Place a '*' or '+' mark after the day
    ---@type string "left" | "left-fit" | "right"
    vim.g.calendar_mark = "right"

    -- Specify the directory for the diary files
    ---@type string
    vim.g.calendar_diary = "$HOME/.vim/diary"

    -- Specify multiple diary configurations.
    vim.g.calendar_diary_list = {
      {
        name = "Note",
        path = "$HOME/.vim/note",
        ext = ".md",
      },
      {
        name = "Diary",
        path = "$HOME/.vim/diary",
        ext = ".diary.md",
      },
    }

    --Specify multiple diary default configuration
    vim.g.calendar_diary_list_curr_idx = 1

    -- To control the calendar navigator, set this variable
    ---@type string "top" | "bottom" | "both" | ""
    vim.g.calendar_navi = ""

    -- To set the labels for the calendar navigator, for example to change the language, use this variable.
    -- Entries should be comma separated.
    vim.g.calendar_navi_label = "Prev,Today,Next"

    -- To change the dating system, set the following variable.
    -- Include the name of the dating system and its offset from the Georgian calendar (A.D.).
    -- use the current Japanese era (Heisei)
    vim.g.calendar_erafmt = "Heisei,-1988"

    -- To change the month names for the calendar headings, set this variable.
    -- The value is expected to be a comma-separated list of twelve values, starting with January
    vim.g.calendar_mruler = "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"

    -- To change the week names for the calendar headings, set this variable.
    -- The value is expected to be a space-separated list of seven values, starting with Sunday
    vim.g.calendar_wruler = "Su Mo Tu We Th Fr Sa"

    -- To make the week start on Monday rather than Sunday, set this variable
    -- Note that the value of |g:calendar_wruler| is not affected by this;
    -- it should always begin with Sunday
    vim.g.calendar_monday = 1

    local calendar_weeknm = {
      -- WK01
      one = 1,
      -- WK 1
      two = 2,
      -- KW01
      three = 3,
      -- KW 1
      four = 4,
      -- 1
      five = 5,
    }

    -- To show the week number, set this variable.
    vim.g.calendar_weeknm = calendar_weeknm.one

    -- To control display of the current date and time, set this variable
    -- Acceptable values are 'title', 'statusline', and ''
    vim.g.calendar_datetime = "title"

    ---@type string "markdown" | "pandoc"
    vim.g.calendar_filetype = "pandoc"

    -- To control the number of months per view, set this variable.
    -- The default value is 3
    vim.g.calendar_number_of_months = 5

    ---@type string "grep" | "internal"
    vim.g.calendar_search_grepprg = "internal"
  end,
  --cond = false,
  --enabled = false,
}

return spec
