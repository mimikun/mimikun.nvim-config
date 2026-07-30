---@type ReviewTemplate[]
local templates = {
  {
    key = "e",
    label = "Extract",
    text = "Extract this into a separate function/component",
  },
  {
    key = "r",
    label = "Rename",
    text = "Rename to: ",
  },
  {
    key = "m",
    label = "Move",
    text = "Move this to a separate file",
  },
  {
    key = "t",
    label = "Types",
    text = "Add proper types",
  },
  {
    key = "h",
    label = "Error handling",
    text = "Add error handling",
  },
  {
    key = "p",
    label = "Performance",
    text = "Performance concern: ",
  },
  {
    key = "s",
    label = "Simplify",
    text = "Simplify this",
  },
  {
    key = "d",
    label = "Delete",
    text = "Remove this",
  },
}

return templates
