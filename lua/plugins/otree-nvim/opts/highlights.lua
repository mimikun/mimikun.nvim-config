---@type table
local highlights = {
  directory = "Directory",
  file = "Normal",
  tree = "Comment",
  title = "Title",
  float_normal = "NormalFloat",
  float_border = "FloatBorder",
  link_path = "Comment",
  git_ignored = "NonText",
  git_untracked = "DiagnosticInfo",
  git_modified = "DiagnosticWarn",
  git_added = "DiagnosticHint",
  git_deleted = "DiagnosticError",
  git_conflict = "DiagnosticError",
  git_renamed = "DiagnosticHint",
  git_copied = "DiagnosticHint",
  lsp_warn = "DiagnosticWarn",
  lsp_info = "DiagnosticInfo",
  lsp_hint = "DiagnosticHint",
  lsp_error = "DiagnosticError",
}

return highlights
