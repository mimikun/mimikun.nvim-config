---@type notify.Config
local opts = {
  -- Minimum log level to display. See vim.log.levels.
  ---@type string | integer | nil
  level = vim.log.levels.INFO,
  --level = 2,

  -- Default timeout for notification
  ---@type number
  timeout = 5000,

  -- Max number of columns for messages
  ---@type number | function | nil
  max_width = nil,

  -- Max number of lines for a message
  ---@type number | function | nil
  max_height = nil,

  -- Animation stages
  ---@type string | function[] | nil | "fade" | "slide" | "slide_out" | "fade_in_slide_out" | "static"
  stages = "fade_in_slide_out",

  -- Function to render a notification buffer or a built-in renderer name
  ---@type function | string | nil  | "default" | "minimal"
  render = "default",

  -- For stages that change opacity this is treated as the highlight behind the window.
  -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
  ---@type string
  background_colour = "NotifyBackground",

  -- Function called when a new window is opened, use for changing win settings/config
  ---@type function
  on_open = nil,

  -- Function called when a window is closed
  ---@type function
  on_close = nil,

  -- Minimum width for notification windows
  ---@type integer
  minimum_width = 50,

  -- Frames per second for animation stages, higher value means smoother animations but more CPU usage
  ---@type integer
  fps = 30,

  -- whether or not to position the notifications at the top or not
  ---@type boolean
  top_down = true,

  -- whether to replace visible notification if new one is the same, can be an integer for min duplicate count
  ---@type boolean | integer
  merge_duplicates = true,

  -- Time formats for different kind of notifications
  ---@type table
  time_formats = {
    notification = "%T",
    notification_history = "%FT%T",
  },

  -- Icons for each level (upper case names)
  ---@type table
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = "",
  },
}

return opts
