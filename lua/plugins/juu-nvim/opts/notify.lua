-- Notification system (enabled by default, set to false to disable)
---@type JuuNotifyUserConfig | false | nil
local notify = {
  -- Set to false to disable the notification system
  ---@type boolean |nil
  --enabled = true,

  -- Override vim.notify() (default: true)
  ---@type boolean |nil
  override_vim_notify = true,

  -- Poll rate for updating notifications (Hz)
  ---@type number | nil
  poll_rate = 10,

  -- Minimum notification level to display
  filter = vim.log.levels.INFO,

  -- Number of removed messages to retain in history
  ---@type number | nil
  history_size = 128,

  -- Window configuration
  ---@type JuuNotifyWindowConfig | nil
  window = {
    -- Base highlight group
    normal_hl = "Comment",
    -- Background opacity
    winblend = 100,
    -- Border style
    border = "none",
    -- Stacking priority
    zindex = 45,
    -- Maximum width (0 = auto)
    max_width = 0,
    -- Maximum height (0 = auto)
    max_height = 0,
    -- Padding from right edge
    x_padding = 1,
    -- Padding from bottom edge
    y_padding = 0,
    -- Window alignment
    align = "bottom",
    -- Position relative to
    relative = "editor",
    -- Filetypes to avoid
    avoid = {
      --"NvimTree"
    },
  },

  -- Notification group configuration
  ---@type table<string, JuuNotifyGroupConfig> | nil
  configs = {
    default = {
      -- Enable colored message text based on log level (default: true)
      color_messages = true,

      -- Enable borders around notification items (default: true)
      borders = true,

      -- Highlight styles for different log levels
      debug_style = "Comment",
      info_style = "Question",
      warn_style = "WarningMsg",
      error_style = "ErrorMsg",
    },
  },

  -- View/rendering configuration
  ---@type JuuNotifyViewConfig | nil
  --view = nil,

  -- Conditionally redirect notifications to another backend
  ---@type false | fun(msg: string | nil, level: number | string | nil, opts: table | nil): (boolean | nil) | nil
  --redirect = nil,
}

return notify
