---@type table
local events = {
  --"VeryLazy",
  -- conform formats on BufWritePre, so linting on BufWritePost always sees the formatted buffer
  "BufReadPost",
  "BufWritePost",
}

return events
