---@type table
local opts = {
  --- default groups
  ---@type table
  groups = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLine",
    "CursorLineNr",
    "StatusLine",
    "StatusLineNC",
    "EndOfBuffer",
  },
  --- additional groups that should be cleared
  ---@type table
  extra_groups = {},
  --- groups you don't want to clear
  ---@type table
  exclude_groups = {},
}

return opts
