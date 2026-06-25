local default_config = {
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = true,

    -- Default prompt string
    default_prompt = "Input",

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    -- Can be 'left', 'right', or 'center'
    title_pos = "left",

    -- The initial mode when the window opens (insert|normal|visual|select).
    start_mode = "insert",

    -- These are passed to nvim_open_win
    border = "rounded",
    -- 'editor' and 'win' will default to being centered
    relative = "cursor",

    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    width = nil,
    -- min_width and max_width can be a list of mixed types.
    -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },

    buf_options = {},
    win_options = {
      -- Disable line wrapping
      wrap = false,
      -- Indicator for when text exceeds window
      list = true,
      listchars = "precedes:…,extends:…",
      -- Increase this for more context when text scrolls off the window
      sidescrolloff = 0,
    },

    -- Set to `false` to disable
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },

    override = function(conf)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,

    get_config = nil,
  },
  select = {
    -- Set to false to disable the vim.ui.select implementation
    enabled = true,

    -- Priority list of preferred vim.select implementations
    backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    -- Options for telescope selector
    -- These are passed into the telescope picker directly. Can be used like:
    -- telescope = require('telescope.themes').get_ivy({...})
    telescope = nil,

    -- Options for fzf selector
    fzf = {
      window = {
        width = 0.5,
        height = 0.4,
      },
    },

    -- Options for fzf-lua
    fzf_lua = {
      -- winopts = {
      --   height = 0.5,
      --   width = 0.5,
      -- },
    },

    -- Options for nui Menu
    nui = {
      position = "50%",
      size = nil,
      relative = "editor",
      border = {
        style = "rounded",
      },
      buf_options = {
        swapfile = false,
        filetype = "JuuSelect",
      },
      win_options = {
        winblend = 0,
      },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 10,
    },

    -- Options for built-in selector
    builtin = {
      -- Display numbers for options and set up keymaps
      show_numbers = true,
      -- These are passed to nvim_open_win
      border = "rounded",
      -- 'editor' and 'win' will default to being centered
      relative = "editor",

      buf_options = {},
      win_options = {
        cursorline = true,
        cursorlineopt = "both",
        -- disable highlighting for the brackets around the numbers
        winhighlight = "MatchParen:",
        -- adds padding at the left border
        statuscolumn = " ",
      },

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- the min_ and max_ options can be a list of mixed types.
      -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
      width = nil,
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      height = nil,
      max_height = 0.9,
      min_height = { 10, 0.2 },

      -- Set to `false` to disable
      mappings = {
        ["<Esc>"] = "Close",
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
      },

      override = function(conf)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
      end,
    },

    -- Used to override format_item.
    format_item_override = {},

    get_config = nil,
  },
  notify = {
    -- Set to false to disable the notification system
    enabled = true,

    -- How frequently to update and render notifications (Hz)
    poll_rate = 10,

    -- Minimum notification level to display
    -- Set to vim.log.levels.OFF to filter out all notifications with a numeric level
    -- Set to vim.log.levels.TRACE to turn off filtering
    filter = vim.log.levels.INFO,

    -- Number of removed messages to retain in history
    -- Set to 0 to keep history indefinitely (until cleared)
    history_size = 128,

    -- Automatically override vim.notify() with Juu
    override_vim_notify = true,

    -- Window configuration
    window = {
      -- Base highlight group in the notification window
      normal_hl = "Comment",

      -- Background color opacity (0-100)
      winblend = 100,

      -- Border around the notification window
      border = "none",

      -- Highlight group for notification window border
      -- Set to empty string to use theme's default FloatBorder
      border_hl = "",

      -- Stacking priority of the notification window
      zindex = 45,

      -- Maximum width (0 = no limit, or fraction like 0.5 for 50% of editor width)
      max_width = 0,

      -- Maximum height (0 = no limit)
      max_height = 0,

      -- Padding from right edge
      x_padding = 1,

      -- Padding from bottom edge
      y_padding = 0,

      -- How to align the notification window
      align = "bottom",

      -- What the notification window position is relative to
      relative = "editor",

      -- Width of each tab character
      tabstop = 8,

      -- Filetypes to avoid when positioning window
      avoid = {},
    },

    -- View/rendering configuration
    view = {
      -- Display notification items from bottom to top
      stack_upwards = true,

      -- How to indent messages longer than a single line
      align = "message",

      -- Reflow (wrap) messages wider than notification window
      -- Options: "hard", "hyphenate", "ellipsis", or false
      reflow = false,

      -- Separator between group name and icon
      icon_separator = " ",

      -- Separator between notification groups (set to false to omit)
      group_separator = "--",

      -- Highlight group for group separator
      group_separator_hl = "Comment",

      -- Spaces to pad both sides of each non-empty line
      line_margin = 1,

      -- How to render notification messages with counts
      render_message = function(msg, cnt)
        return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
      end,
    },

    -- Notification group configurations
    -- A configuration with the key "default" should always be specified
    configs = {
      default = {
        -- Group name
        name = "Notifications",

        -- Group icon
        icon = "❰❰",

        -- How long a notification item should exist (seconds)
        ttl = 5,

        -- Highlight styles
        group_style = "Title",
        icon_style = "Special",
        annote_style = "Question",
        debug_style = "Comment",
        info_style = "Question",
        warn_style = "WarningMsg",
        error_style = "ErrorMsg",

        -- Default annotations for log levels
        debug_annote = "DEBUG",
        info_annote = "INFO",
        warn_annote = "WARN",
        error_annote = "ERROR",

        -- Enable colored message text based on log level
        color_messages = true,

        -- Enable borders around notification items
        borders = true,

        -- Separator between message and annote
        annote_separator = " ",

        -- How many notification items to show at once
        render_limit = nil,

        -- Priority for ordering groups
        priority = 50,
      },
    },

    -- Conditionally redirect notifications to another backend
    -- Useful for delegating to backends that support features Juu doesn't
    redirect = false,
  },

  -- Floating cmdline (requires Neovim 0.12+ ui2). Set to false to disable.
  cmdline = {
    enabled = true,

    width = {
      value = "60%",
      min = 40,
      max = 80,
    },
    position = {
      x = "50%",
      y = "50%",
    },
    border = nil,
    menu_col_offset = 3,
    -- Empty: all cmdline types (including / and ?) use the centered float. Set e.g. { "/", "?" } for full-width bottom search.
    native_types = {},
    on_reposition = nil,
  },

  -- Redirect editor messages (|:write|, |:echo|, etc.) to |vim.notify| via |ui-messages|.
  -- Requires notifications (notify ~= false). Disabled automatically if noice.nvim is loaded.
  messages = {
    enabled = true,
    exclude_kinds = nil,
    include_kinds = nil,
    filter = nil,
    opts = nil,
    -- Avoid duplicate notifications when Nvim emits the same text twice in one batch (e.g. :write).
    dedupe_ms = 200,
  },
}
