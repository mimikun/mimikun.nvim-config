-- Pwned passwords check configuration
---@type CamouflagePwnedConfig
local pwned = {
  -- Manual HIBP commands are available
  -- Feature toggle
  ---@type boolean | true
  enabled = true,

  -- Network check on BufEnter (opt in)
  ---@type boolean | false
  auto_check = false,

  -- Network check on BufWritePost (opt in)
  ---@type boolean | false
  check_on_save = false,

  -- Network check on TextChanged (opt in)
  ---@type boolean | false
  check_on_change = false,

  -- Show sign column indicator
  ---@type boolean | true
  show_sign = true,

  -- Show virtual text
  ---@type boolean | true
  show_virtual_text = true,

  -- Highlight the line
  ---@type boolean | true
  show_line_highlight = true,

  -- Sign icon
  ---@type string | "!"
  sign_text = "!",

  -- Sign highlight group
  ---@type string | "DiagnosticWarn"
  sign_hl = "DiagnosticWarn",

  -- Virtual text format
  ---@type string | "PWNED (%s)"
  virtual_text_format = "PWNED (%s)",

  -- Virtual text highlight
  ---@type string | "DiagnosticWarn"
  virtual_text_hl = "DiagnosticWarn",

  -- Line highlight group
  ---@type string | "CamouflagePwned"
  line_hl = "CamouflagePwned",
}

return pwned
