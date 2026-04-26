-- lua/line-justice/themes/dawn.lua
--
-- "Dawn" — a warm sunrise theme for line-justice.nvim.
--
-- Soft amber and rose tones evoking early morning light. Designed to pair
-- well with light-background or warm-toned dark colorschemes such as
-- Rosé Pine, Catppuccin Latte, and Gruvbox.
--
-- ┌──────────────────┬──────────┬──────────────────────────────────────────┐
-- │ Key              │ Hex      │ Description                              │
-- ├──────────────────┼──────────┼──────────────────────────────────────────┤
-- │ CursorLine       │ #d4885a  │ Warm amber-orange, bold — cursor row     │
-- │ AbsoluteAbove    │ #9a7560  │ Muted earth brown — absolute above       │
-- │ AbsoluteBelow    │ #7d5c3b  │ Deeper wood brown — absolute below       │
-- │ RelativeAbove    │ #c9a87c  │ Sandy gold — relative above              │
-- │ RelativeBelow    │ #b07d5e  │ Terracotta — relative below              │
-- │ WrappedLine      │ #9a7560  │ Same earth brown as AbsoluteAbove,italic │
-- └──────────────────┴──────────┴──────────────────────────────────────────┘

---@type LineJusticeThemeSpec
return {
  name = "Dawn",
  description = "Warm amber and rose tones evoking early morning light.",
  author = "Zak Siddiqui",
  colors = {
    CursorLine = { fg = "#d4885a", bold = true },
    AbsoluteAbove = { fg = "#9a7560" },
    AbsoluteBelow = { fg = "#7d5c3b" },
    RelativeAbove = { fg = "#c9a87c" },
    RelativeBelow = { fg = "#b07d5e" },
    WrappedLine = { fg = "#9a7560", italic = true },
  },
}
