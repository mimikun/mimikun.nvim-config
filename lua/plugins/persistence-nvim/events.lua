---@type table
local events = {
  -- this will only start session saving when an actual file was opened
  "BufReadPre",
  --"VeryLazy",
}

return events
