-- Available, not mapped yet:
-- Libraries used by the modules above (and usable directly):
---@type snacks.layout.Config
local layout = {

  -- layout definition
  ---@type snacks.layout.Box
  layout = {
    width = 0.6,
    height = 0.6,
    zindex = 50,
  },

  -- show the layout on creation (default: true)
  ---@type boolean
  --show

  -- windows to include in the layout
  ---@type table<string, snacks.win>
  --wins

  -- open in fullscreen
  ---@type boolean
  --fullscreen

  -- list of windows that will be excluded from the layout (but can be toggled)
  ---@type string[]
  --hidden

  ---@type fun(layout: snacks.layout)
  --on_update = function(_layout)
  --end,

  ---@type fun(layout: snacks.layout)
  --on_update_pre = function(_layout)
  --end,

  ---@type fun(layout: snacks.layout)
  --on_close = function(_layout)
  --end,
}

return layout
