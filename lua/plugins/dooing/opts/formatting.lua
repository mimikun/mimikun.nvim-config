-- To-do formatting
local formatting = {
  pending = {
    icon = "○",
    -- Pattern 1
    format = {
      "icon",
      "notes_icon",
      "text",
      "due_date",
      "ect",
    },
    -- Pattern 2
    --format = {
    --  "notes_icon",
    --  "icon",
    --  "text",
    --  "ect",
    --  "due_date",
    --  "relative_time",
    --},
  },
  in_progress = {
    icon = "◐",
    -- Pattern 1
    format = {
      "icon",
      "text",
      "due_date",
      "ect",
    },
    -- Pattern 2
    --format = {
    --  "notes_icon",
    --  "icon",
    --  "text",
    --  "ect",
    --  "due_date",
    --  "relative_time",
    --},
  },
  done = {
    icon = "✓",
    -- Pattern 1
    format = {
      "icon",
      "notes_icon",
      "text",
      "due_date",
      "ect",
    },
    -- Pattern 2
    --format = {
    --  "notes_icon",
    --  "icon",
    --  "text",
    --  "ect",
    --  "due_date",
    --  "relative_time",
    --},
  },
}

return formatting
