-- lua/line-justice/themes/horizon.lua
--
-- "Horizon" — the default built-in colour theme for line-justice.nvim.
--
-- Inspired by a crisp horizon line: cool blue-purple sky above the cursor,
-- fresh green earth below. Hand-crafted colours tuned for TokyoNight-family
-- colorschemes but great on any dark theme.
--
-- ┌──────────────────┬──────────┬──────────────────────────────────────────┐
-- │ Key              │ Hex      │ Description                              │
-- ├──────────────────┼──────────┼──────────────────────────────────────────┤
-- │ CursorLine       │ #FF966C  │ Soft violet, bold — stands out on cursor │
-- │ AbsoluteAbove    │ #565f89  │ Muted blue-grey — absolute nums above    │
-- │ AbsoluteBelow    │ #41664f  │ Deep forest green — absolute below       │
-- │ RelativeAbove    │ #7b9ac7  │ Brighter steel blue — relative above     │
-- │ RelativeBelow    │ #6aa781  │ Brighter sage green — relative below     │
-- │ WrappedLine      │ #565f89  │ Same blue-grey as AbsoluteAbove, italic  │
-- └──────────────────┴──────────┴──────────────────────────────────────────┘

---@type LineJusticeThemeSpec
return {
  name = "Horizon",
  description = "Cool blue-purple sky above the cursor, fresh green earth below. And the setting sun indicates the current line",
  author = "Zak Siddiqui",
  colors = {
    CursorLine = { fg = "#FF966C", bold = true },
    AbsoluteAbove = { fg = "#565f89" },
    AbsoluteBelow = { fg = "#41664f" },
    RelativeAbove = { fg = "#7b9ac7" },
    RelativeBelow = { fg = "#6aa781" },
    WrappedLine = { fg = "#565f89", italic = true },
  },
}
