-- History panel configuration (for :CodeDiff history)
local history = {
  -- "left" or "bottom" (default: bottom)
  ---@type string | "left" | "bottom"
  position = "bottom",

  -- Width when position is "left" (columns)
  width = 40,

  -- Height when position is "bottom" (lines)
  height = 15,

  -- Initial focus
  ---@type string | "history" | "original" | "modified"
  initial_focus = "history",

  -- "list" or "tree" for files under commits
  ---@type string | "list" | "tree"
  view_mode = "list",
}

return history
