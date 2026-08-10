-- Settings for the line-number columns.
---@type LineJusticeLineNumbers
local line_numbers = {
  -- Name of a built-in colour palette, or nil to auto-detect from your active colorscheme.
  -- "Horizon"  = cool blues above, greens below (default).
  -- "Dawn"     = warm amber and rose tones.
  -- "Midnight" = cool monochrome blue-greys.
  -- nil        = auto-detect from your colorscheme.
  ---@type string | "Horizon" | "Dawn" | "Midnight" | nil
  theme = nil,

  -- Per-key colour tweaks applied on top of the theme or auto-detect.
  -- Any key you omit is left exactly as the theme/auto-detect defines it.
  -- All keys are optional; provide only the ones you want to change.
  ---@type LineJusticeOverrides | nil
  overrides = {
    -- The line the cursor is currently on
    ---@type table
    CursorLine = {
      --fg = "#FF966C",
      --bold = true,
    },

    -- Absolute line numbers on lines above the cursor
    ---@type table
    AbsoluteAbove = {
      --fg = "#565f89",
    },

    -- Absolute line numbers on lines below the cursor
    ---@type table
    AbsoluteBelow = {
      --fg = "#41664f",
    },

    -- Relative distance for lines above the cursor
    ---@type table
    RelativeAbove = {
      --fg = "#7b9ac7",
    },

    -- Relative distance for lines below the cursor
    ---@type table
    RelativeBelow = {
      --fg = "#6aa781",
    },

    -- Colour of the wrapped-line indicator character
    ---@type table
    WrappedLine = {
      --fg = "#565f89",
      --italic = true,
    },
  },
}

return line_numbers
