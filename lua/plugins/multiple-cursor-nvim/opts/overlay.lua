---@alias MultipleCursor.OverlayPosition | "top-left" | "top-right" | "bottom-left" | "bottom-right"

-- Floating overlay window for selection count (easier to see)
-- Overlay window configuration
---@type MultipleCursor.OverlayConfig
local overlay = {
  -- Enable/disable the overlay window
  ---@type boolean
  enabled = true,

  -- Position on screen
  ---@type MultipleCursor.OverlayPosition | "top-left" | "top-right" | "bottom-left" | "bottom-right"
  position = "top-right",

  -- Padding from screen edges
  ---@type MultipleCursor.OverlayPadding
  padding = {
    -- Padding from top edge (default: 1)
    ---@type number
    top = 1,

    -- Padding from right edge (default: 1)
    ---@type number
    right = 1,

    -- Padding from bottom edge (default: 1)
    ---@type number
    bottom = 1,

    -- Padding from left edge (default: 1)
    ---@type number
    left = 1,
  },
}

return overlay
