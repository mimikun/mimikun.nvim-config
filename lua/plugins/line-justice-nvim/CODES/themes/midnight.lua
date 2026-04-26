-- lua/line-justice/themes/midnight.lua
--
-- "Midnight" — a cool monochrome theme for line-justice.nvim.
--
-- Desaturated blue-greys that fade into the background. Ideal for
-- distraction-free writing and minimal colorschemes such as GitHub Dark,
-- Zephyr, and Moonfly.
--
-- ┌──────────────────┬──────────┬──────────────────────────────────────────┐
-- │ Key              │ Hex      │ Description                              │
-- ├──────────────────┼──────────┼──────────────────────────────────────────┤
-- │ CursorLine       │ #a9b1d6  │ Pale blue-white, bold — cursor row       │
-- │ AbsoluteAbove    │ #4e5579  │ Cool dark slate — absolute above         │
-- │ AbsoluteBelow    │ #3b4068  │ Deeper navy slate — absolute below       │
-- │ RelativeAbove    │ #6c7494  │ Medium slate blue — relative above       │
-- │ RelativeBelow    │ #565e7a  │ Softer slate — relative below            │
-- │ WrappedLine      │ #4e5579  │ Same dark slate as AbsoluteAbove, italic │
-- └──────────────────┴──────────┴──────────────────────────────────────────┘

---@type LineJusticeThemeSpec
return {
  name = "Midnight",
  description = "Cool, desaturated blue-greys that fade into the background.",
  author = "Zak Siddiqui",
  colors = {
    CursorLine = { fg = "#a9b1d6", bold = true },
    AbsoluteAbove = { fg = "#4e5579" },
    AbsoluteBelow = { fg = "#3b4068" },
    RelativeAbove = { fg = "#6c7494" },
    RelativeBelow = { fg = "#565e7a" },
    WrappedLine = { fg = "#4e5579", italic = true },
  },
}
