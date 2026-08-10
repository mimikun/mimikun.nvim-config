-- Settings for soft-wrapped continuation lines.

-- When a line is too long for the window and wraps, NeoVim renders the continuation as a virtual line.
-- line-justice can show an indicator character in the gutter of those virtual lines, centred in the gutter width, to visually distinguish them from real lines.
---@type LineJusticeWrappedLines
local wrapped_lines = {
  -- "None"     — blank gutter, no character (default)
  -- "Arrow"    — ↳  classic turn-down arrow
  -- "Chevron"  — ›  single right-pointing chevron
  -- "Dot"      — ·  middle dot / interpunct
  -- "Ellipsis" — …  horizontal ellipsis
  -- "Bar"      — │  thin vertical bar
  -- "Custom"   — use the string in wrapped_lines.custom
  ---@type string | "None" | "Arrow" | "Chevron" | "Dot" | "Ellipsis" | "Bar" | "Custom"
  indicator = "Custom",

  -- Only used when indicator = "Custom".
  -- Set this to any character or short string you want to display.
  -- The character (or short string) to display when indicator = "Custom".
  -- Ignored for all other presets.
  ---@type string | "»" | "⤷" | "▸" | "→" | "╰"
  custom = "╰",
}

return wrapped_lines
