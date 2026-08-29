-- decided against, see above
-- zen-mode-nvim
---@type snacks.zen.Config
local zen = {
  -- You can add any `Snacks.toggle` id here.
  -- Toggle state is restored when the window is closed.
  -- Toggle config options are NOT merged.
  ---@type table<string, boolean>
  toggles = {
    dim = true,
    git_signs = false,
    mini_diff_signs = false,
    --diagnostics = false,
    --inlay_hints = false,
  },

  -- center the window
  center = true,

  show = {
    -- can only be shown when using the global statusline
    statusline = false,

    tabline = false,
  },

  ---@type snacks.win.Config
  win = {
    style = "zen",
  },

  -- Callback when the window is opened.
  ---@param win snacks.win
  on_open = function(_win) end,

  --- Callback when the window is closed.
  ---@param win snacks.win
  on_close = function(_win) end,

  --- Options for the `Snacks.zen.zoom()`
  ---@type snacks.zen.Config
  zoom = {
    toggles = {},
    center = false,
    show = {
      statusline = true,
      tabline = true,
    },
    win = {
      backdrop = false,

      -- full width
      width = 0,
    },
  },
}

return zen
