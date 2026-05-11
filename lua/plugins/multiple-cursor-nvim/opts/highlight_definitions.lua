-- vim.api.keyset.highlight
---@alias MultipleCursor.HighlightDefinition

---@type MultipleCursor.HighlightDefinitions
local highlight_definitions = {
  -- Medium Spring Green (selected cursors)
  ---@type MultipleCursor.HighlightDefinition
  cursor = {
    bg = "#00FA9A",
    fg = "#000000",
    bold = true,
  },

  -- Gold (unselected matches)
  ---@type MultipleCursor.HighlightDefinition
  match = {
    bg = "#FFD700",
    fg = "#000000",
    bold = true,
  },

  -- Tomato (skipped)
  ---@type MultipleCursor.HighlightDefinition
  skipped = {
    bg = "#FF6347",
    fg = "#000000",
    bold = true,
  },

  -- Rose Pink (Monokai-inspired)
  ---@type MultipleCursor.HighlightDefinition
  overlay = {
    bg = "#E84A72",
    fg = "#ffffff",
    bold = true,
  },
}

return highlight_definitions
