---@type table
local opts = {
  ---@type boolean
  count = true,

  ---@type boolean
  parent_dirs = true,

  ---@type table<string>
  diagnostic_colors = {
    error = "DiagnosticError",
    warn = "DiagnosticWarn",
    info = "DiagnosticInfo",
    hint = "DiagnosticHint",
  },

  ---@type table<string>
  diagnostic_symbols = {
    error = "",
    warn = "",
    info = "",
    hint = "󰌶",
  },
}

return opts
