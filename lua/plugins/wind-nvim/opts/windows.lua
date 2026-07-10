---@type WindWindowsConfig
local windows = {
  -- Maximum indexed windows (1-9, never above 9)
  ---@type integer
  max = 9,

  ---@type WindFlow
  flow = {
    -- Side where new side-by-side windows appear
    ---@type string | "right" | "left"
    horizontal = "right",

    -- Side where new stacked windows appear
    ---@type string | "below" | "above"
    vertical = "below",
  },

  ---@type WindExcluded
  excluded = {
    -- Filetypes invisible to wind
    ---@type string[]
    filetypes = {
      "neo-tree",
      "NvimTree",
      "netrw",
    },

    -- Lua patterns for buffer names invisible to wind
    ---@type string[]
    bufnames = {},
  },

  -- Show informational notifications
  ---@type boolean
  notify = true,
}

return windows
