---@type LazySpec
local spec = {
  "dstein64/vim-startuptime",
  --lazy = false,
  cmd = require("plugins.vim-startuptime.cmds"),
  event = require("plugins.vim-startuptime.events"),
  init = function()
    -- Key sequence for getting more
    -- Disable with `''` information
    vim.g.startuptime_more_info_key_seq = "K"

    -- Key sequence for loading a sourcing
    -- Disable with `''` event file in a split window
    vim.g.startuptime_split_edit_key_seq = "gf"

    -- Path to `vim` for startup timing
    --vim.g.startuptime_exe_path = "RUNNING_VIM_PATH"

    -- Optional arguments to pass to `vim`
    vim.g.startuptime_exe_args = {
      --"-u",
      --"~/.vim/vimrc",
    }

    -- Specifies whether events are sorted
    vim.g.startuptime_sort = true

    -- Specifies how many startup times are averaged
    vim.g.startuptime_tries = 1

    -- Specifies whether sourcing events are included
    vim.g.startuptime_sourcing_events = true

    -- Specifies whether other events are are included
    vim.g.startuptime_other_events = true

    -- Specifies whether to include 'sourced' timings (in addition to 'self' timings) for sourcing events
    vim.g.startuptime_sourced = true

    -- Event column width.
    -- When set to 0, the column width will be dynamically set so that no text is truncated.
    vim.g.startuptime_event_width = 20

    -- Time column width
    vim.g.startuptime_time_width = 6

    -- Percent column width
    vim.g.startuptime_percent_width = 7

    -- Plot column width
    vim.g.startuptime_plot_width = 26

    -- Specifies whether table data is colorized
    vim.g.startuptime_colorize = true

    -- Specifies whether Unicode block and `false` otherwise elements are used for plotting
    -- if 'encoding' is set to "utf-8"
    vim.g.startuptime_use_blocks = true

    -- Specifies whether 1/8 increments
    -- otherwise are used for Unicode blocks (1/2 increments are used otherwise)
    -- TODO: on Windows, true
    vim.g.startuptime_fine_blocks = false

    -- Indentation for the startup row
    vim.g.startuptime_startup_indent = 7

    -- Specifies whether a debug message is shown when progress is 0%
    vim.g.startuptime_zero_progress_msg = true

    -- Specifies the time in milliseconds before showing a debug message when progress is 0%
    vim.g.startuptime_zero_progress_time = 2000
  end,
  --cond = false,
  --enabled = false,
}

return spec
