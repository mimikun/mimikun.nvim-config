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
---@class JuuNotifyWindowConfig
---@field normal_hl string Base highlight group in the notification window
---@field winblend number Background color opacity (0-100)
---@field border "none"|"single"|"double"|"rounded"|"solid"|"shadow"|string[] Border around the notification window
---@field border_hl string Highlight group for notification window border
---@field zindex number Stacking priority of the notification window
---@field max_width number Maximum width (0 = no limit, or fraction like 0.5 for 50% of editor width)
---@field max_height integer Maximum height (0 = no limit)
---@field x_padding integer Padding from right edge
---@field y_padding integer Padding from bottom edge
---@field align "top"|"bottom"|"avoid_cursor" How to align the notification window
---@field relative "editor"|"win" What the notification window position is relative to
---@field tabstop integer Width of each tab character
---@field avoid string[] Filetypes to avoid when positioning window

---@class JuuNotifyViewConfig
---@field stack_upwards boolean Display notification items from bottom to top
---@field align "message"|"annote" How to indent messages longer than a single line
---@field reflow "hard"|"hyphenate"|"ellipsis"|false Reflow (wrap) messages wider than notification window
---@field icon_separator string Separator between group name and icon
---@field group_separator string|false Separator between notification groups (set to false to omit)
---@field group_separator_hl string|false Highlight group for group separator
---@field line_margin integer Spaces to pad both sides of each non-empty line
---@field render_message fun(msg: string, cnt: number): (string|false|nil) How to render notification messages with counts

---@alias JuuNotifyDisplay string|false|fun(now: number, items: table[]): (string|false|nil) Something that can be displayed (string, false, or function)

---@class JuuNotifyGroupConfig
---@field name JuuNotifyDisplay|nil Name of the group
---@field icon JuuNotifyDisplay|nil Icon of the group
---@field icon_on_left boolean|nil If true, icon is rendered on the left instead of right
---@field annote_separator string|nil Separator between message from annote; defaults to " "
---@field ttl number|nil How long a notification item should exist; defaults to 5
---@field render_limit number|nil How many notification items to show at once
---@field group_style string|nil Style used to highlight group name; defaults to "Title"
---@field icon_style string|nil Style used to highlight icon; if nil, use group_style
---@field annote_style string|nil Default style used to highlight item annotes; defaults to "Question"
---@field debug_style string|nil Style used to highlight debug item annotes
---@field info_style string|nil Style used to highlight info item annotes
---@field warn_style string|nil Style used to highlight warn item annotes
---@field error_style string|nil Style used to highlight error item annotes
---@field debug_annote string|nil Default annotation for debug items
---@field info_annote string|nil Default annotation for info items
---@field warn_annote string|nil Default annotation for warn items
---@field error_annote string|nil Default annotation for error items
---@field priority number|nil Order in which group should be displayed; defaults to 50
---@field skip_history boolean|nil Whether messages should be preserved in history
---@field update_hook fun(item: table)|false|nil Called when an item is updated; defaults to false
---@field color_messages boolean|nil Whether to apply log level colors to message text (defaults to true)
---@field borders boolean|nil Whether to display borders around notification items (defaults to true)
