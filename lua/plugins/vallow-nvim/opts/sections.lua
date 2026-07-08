-- Reorder tabs. Omitted sections keep their default order after listed ones.
-- section_order = { "health", "issues", "duplicates", "unused_code", "architecture" },
---@type table
local sections = {
  unused_code = {
    icon = "󰈔",
    label = "UNUSED CODE",
    order = 1,
  },
  issues = {
    icon = "󰅖",
    label = "ISSUES",
    order = 2,
  },
  duplicates = {
    icon = "󰏗",
    label = "DUPLICATES",
    order = 3,
  },
  health = {
    icon = "󰚰",
    label = "HEALTH",
    order = 4,
  },
  architecture = {
    icon = "󰑷",
    label = "ARCHITECTURE",
    order = 5,
  },
}

return sections
