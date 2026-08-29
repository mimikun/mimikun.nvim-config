-- Available, not mapped yet:
-- Libraries used by the modules above (and usable directly):
---@class snacks.win.Config: vim.api.keyset.win_config
---@type snacks.win.Config
local win = {
  -- Show the window immediately (default: true)
  ---@type boolean
  show = true,

  -- don't allow other buffers to be opened in this window
  ---@type boolean
  fixbuf = true,
  relative = "editor",

  ---@type string | "float" | "bottom" | "top" | "left" | "right" | "current"
  position = "float",

  -- Disable a bunch of options to make the window minimal (default: true)
  ---@type boolean
  minimal = true,

  -- window options
  ---@type vim.wo | {}
  wo = {
    winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC,FloatTitle:SnacksTitle,FloatFooter:SnacksFooter,WinSeparator:SnacksWinSeparator",
  },

  -- buffer options
  ---@type vim.bo | {}
  bo = {},
  title_pos = "center",

  -- Key mappings
  ---@type table<string, false | string | fun(self: snacks.win) | snacks.win.Keys>
  keys = {
    q = "close",
  },
  footer_pos = "center",

  -- Show keys footer.
  -- When string[], only show those keys with lhs (default: false)
  ---@type boolean | string[] | false
  footer_keys = false,

  -- TODO:

  ---@field style? string merges with config from `Snacks.config.styles[style]`
  ---@field height? number|fun(self:snacks.win):number Height of the window. Use <1 for relative height. 0 means full height. (default: 0.9)
  ---@field width? number|fun(self:snacks.win):number Width of the window. Use <1 for relative width. 0 means full width. (default: 0.9)
  ---@field min_height? number Minimum height of the window
  ---@field max_height? number Maximum height of the window
  ---@field min_width? number Minimum width of the window
  ---@field max_width? number Maximum width of the window
  ---@field col? number|fun(self:snacks.win):number Column of the window. Use <1 for relative column. (default: center)
  ---@field row? number|fun(self:snacks.win):number Row of the window. Use <1 for relative row. (default: center)
  ---@field border? "none"|"top"|"right"|"bottom"|"left"|"top_bottom"|"hpad"|"vpad"|"rounded"|"single"|"double"|"solid"|"shadow"|"bold"|string[]|false|true
  ---@field buf? number If set, use this buffer instead of creating a new one
  ---@field file? string If set, use this file instead of creating a new buffer
  ---@field enter? boolean Enter the window after opening (default: false)
  ---@field backdrop? number|false|snacks.win.Backdrop Opacity of the backdrop (default: 60)
  ---@field b? table<string, any> buffer local variables
  ---@field w? table<string, any> window local variables
  ---@field ft? string filetype to use for treesitter/syntax highlighting. Won't override existing filetype
  ---@field scratch_ft? string filetype to use for scratch buffers
  ---@field on_buf? fun(self: snacks.win) Callback after opening the buffer
  ---@field on_win? fun(self: snacks.win) Callback after opening the window
  ---@field on_close? fun(self: snacks.win) Callback after closing the window
  ---@field text? string|string[]|fun():(string[]|string) Initial lines to set in the buffer
  ---@field actions? table<string, snacks.win.Action.spec> Actions that can be used in key mappings
  ---@field resize? boolean Automatically resize the window when the editor is resized
  ---@field stack? boolean When enabled, multiple split windows with the same position will be stacked together (useful for terminals)
}

return win
