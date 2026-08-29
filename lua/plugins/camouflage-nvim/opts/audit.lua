-- Workspace audit configuration
---@type CamouflageAuditConfig
local audit = {
  -- Root-relative globs or basename globs skipped by workspace audit
  ---@type string[]
  ignore_patterns = {
    ".git",
    ".git/**",
    "node_modules",
    "node_modules/**",
  },

  -- Number of discovered files processed per scheduled async chunk
  ---@type integer
  max_files_per_chunk = 50,

  ---@type string | "quickfix" | "loclist"
  destination = "quickfix",

  -- Open quickfix/location-list after findings are written
  ---@type boolean
  open = true,

  -- Show audit completion notifications
  ---@type boolean
  notify = true,
}

return audit
