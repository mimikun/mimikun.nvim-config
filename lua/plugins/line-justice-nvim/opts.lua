---@type table
local opts = {
  line_numbers = {
    -- Name of a built-in colour palette, or nil to auto-detect from your active colorscheme.
    ---@type string | nil | "Horizon"
    theme = "Horizon",

    -- Per-key colour tweaks applied on top of the theme or auto-detect.
    -- Any key you omit is left exactly as the theme/auto-detect defines it.
    -- All keys are optional; provide only the ones you want to change.
    ---@type table | nil
    --overrides = {
    --  CursorLine = {
    --    fg = "#FF966C",
    --    bold = true,
    --  },
    --  AbsoluteAbove = {
    --    fg = "#565f89",
    --  },
    --  AbsoluteBelow = {
    --    fg = "#41664f",
    --  },
    --  RelativeAbove = {
    --    fg = "#7b9ac7",
    --  },
    --  RelativeBelow = {
    --    fg = "#6aa781",
    --  },
    --  WrappedLine = {
    --    fg = "#565f89",
    --    italic = true,
    --  },
    --},
  },

  wrapped_lines = {
    -- Named indicator preset shown in the gutter of soft-wrapped continuation lines, centred in the gutter width.
    -- "None"     — blank gutter
    -- "Arrow"    — ↳
    -- "Chevron"  — ›
    -- "Dot"      — ·
    -- "Ellipsis" — …
    -- "Bar"      — │
    -- "Custom"   — use the string in wrapped_lines.custom
    ---@type string | "None" | "Arrow" | "Chevron" | "Dot" | "Ellipsis" | "Bar" | "Custom"
    indicator = "Custom",

    -- Only used when indicator = "Custom".
    -- Set this to any character or short string you want to display.
    ---@type string | "»" | "⤷" | "▸" | "→" | "╰"
    custom = "╰",
  },
}

return opts
