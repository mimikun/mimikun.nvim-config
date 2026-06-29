---@type table
local events = {
  --"VeryLazy",
  -- Load before session save/restore so VimLeavePre and SessionLoadPost hooks are registered.
  "SessionLoadPost",
  "VimLeavePre",
}

return events
