local builtin = require("statuscol.builtin")

-- builtin click handlers, keys are pattern matched
---@type table
local clickhandlers = {
  Lnum = builtin.lnum_click,
  FoldClose = builtin.foldclose_click,
  FoldOpen = builtin.foldopen_click,
  FoldOther = builtin.foldother_click,
  DapBreakpointRejected = builtin.toggle_breakpoint,
  DapBreakpoint = builtin.toggle_breakpoint,
  DapBreakpointCondition = builtin.toggle_breakpoint,
  ["diagnostic/signs"] = builtin.diagnostic_click,
  gitsigns = builtin.gitsigns_click,
}

return clickhandlers
