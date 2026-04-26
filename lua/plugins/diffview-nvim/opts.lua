---@type table
local opts = {
  enhanced_diff_hl = true,
  use_icons = true,
  view = {
    default = {
      layout = "diff2_horizontal",
    },
    merge_tool = {
      layout = "diff3_horizontal",
    },
  },
  file_panel = {
    listing_style = "tree",
    win_config = {
      -- Use "auto" to fit content
      position = "left",
      width = 35,
    },
  },
  -- See :h diffview-config-hooks
  hooks = {},
  -- See :h diffview-config-keymaps
  keymaps = {},
}

return opts
