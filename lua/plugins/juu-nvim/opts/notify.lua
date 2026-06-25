-- Notification system (enabled by default, set to false to disable)
---@type JuuNotifyUserConfig | false | nil
local notify = {
  -- Override vim.notify() (default: true)
  override_vim_notify = true,

  -- Poll rate for updating notifications (Hz)
  poll_rate = 10,

  -- Minimum notification level to display
  filter = vim.log.levels.INFO,

  -- Number of removed messages to retain in history
  history_size = 128,

  -- Window configuration
  window = {
    normal_hl = "Comment", -- Base highlight group
    winblend = 100, -- Background opacity
    border = "none", -- Border style
    zindex = 45, -- Stacking priority
    max_width = 0, -- Maximum width (0 = auto)
    max_height = 0, -- Maximum height (0 = auto)
    x_padding = 1, -- Padding from right edge
    y_padding = 0, -- Padding from bottom edge
    align = "bottom", -- Window alignment
    relative = "editor", -- Position relative to
    avoid = {}, -- Filetypes to avoid (e.g., { "NvimTree" })
  },

  -- Notification group configuration
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
}

return notify
