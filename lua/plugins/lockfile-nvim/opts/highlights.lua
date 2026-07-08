-- Each plugin highlight group links (with default = true) to the target below.
-- map of plugin hl group -> linked group
---@type table<string,string>
local highlights = {
  LockfileAdded = "DiffAdd",
  LockfileRemoved = "DiffDelete",
  LockfileUpdated = "DiffChange",
  LockfileSuspicious = "DiagnosticError",
  LockfileHeader = "Title",
  LockfileSection = "Function",
  LockfileVersion = "Number",
  LockfileVersionOld = "Comment",
  LockfileName = "Identifier",
  LockfileReason = "Comment",
  LockfileSource = "String",
  LockfileMuted = "NonText",
  LockfileMajor = "WarningMsg",
}

return highlights
