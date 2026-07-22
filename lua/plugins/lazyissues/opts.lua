---@type table
local opts = {
  -- float width as a fraction of the editor
  width = 0.92,

  -- float height
  height = 0.88,

  -- reload from disk on FocusGained
  auto_refresh = true,

  assignees = {
    "Unassigned",
    --"Alice",
    --"Bob",
  },

  comment_authors = {
    --"Alice",
    --"Bob",
  },
}

return opts
