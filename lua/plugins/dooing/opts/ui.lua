-- Interface style (see "Modern UI" below).
-- Opt-in: the default keeps the original look, so updating never changes your interface.
-- `style = "classic"` (the default) keeps the original rendering untouched;
-- `style = "modern"` enables the reworked layout.
-- The individual toggles below only apply to the modern style and can each be turned off to mix and match.
local ui = {
  ---@type string | "classic" | "modern"
  style = "classic",

  -- group top-level todos under status headings
  sections = true,

  -- colored marker instead of coloring the whole row
  priority_bar = true,

  -- draw ├─ / └─ / │ guides for nested tasks
  tree_connectors = true,

  -- first line of a todo's notes, dimmed, beneath it
  note_preview = true,

  -- progress bar in the title, summary in the footer
  progress = true,

  -- single strip instead of the tall quick keys panel
  compact_quick_keys = true,

  section_titles = {
    in_progress = "IN PROGRESS",
    pending = "PENDING",
    done = "DONE",
  },
  icons = {
    priority_bar = "▎",
    overdue = "󰀦",
    progress_on = "▰",
    progress_off = "▱",
  },
}

return ui
