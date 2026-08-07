local priority_groups = {
  high = {
    members = {
      "important",
      "urgent",
    },
    color = nil,
    hl_group = "DiagnosticError",
  },
  medium = {
    members = {
      "important",
    },
    color = nil,
    hl_group = "DiagnosticWarn",
  },
  low = {
    members = {
      "urgent",
    },
    color = nil,
    hl_group = "DiagnosticInfo",
  },
}

return priority_groups
