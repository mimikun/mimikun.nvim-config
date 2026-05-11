---@type MultipleCursor.Highlights
local highlights = {
  -- Highlight group for selected cursors
  ---@type string
  cursor = "MultipleCursor",

  -- Highlight group for unselected matches
  ---@type string
  match = "MultipleCursorMatch",

  -- Highlight group for skipped matches
  ---@type string
  skipped = "MultipleCursorSkipped",
}

return highlights
