---@type table
local opts = {
  colors = {
    cursor = "#FFFFFF",
    search = "#FF77AA",
    mark = "#FFD866",
    selection = "#6CA0C8",
    viewport = "#888888",
    error = "#FC6161",
    warn = "#FFA348",
    info = "#67D4F0",
    hint = "#C792EA",
    git_add = "#7FCC7F",
    git_change = "#7FAFFF",
    git_delete = "#FC6161",
    base = "#444444",
    divider = "#6B7280",
    file = "#AAAAAA",
    dim = "#444444",
    info_txt = "#BBBBBB",
  },
  dividers = {
    enabled = true,
    min_run = 4,
    glyph = "|",
    chars = {
      "-",
      "=",
      "_",
      "~",
      "*",
      "#",
      "─",
      "═",
      "━",
    },
  },
}

return opts
