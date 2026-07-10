-- Custom patterns for unsupported file types
---@type CamouflageCustomPatternConfig[]
local custom_patterns = {
  -- File pattern (glob)
  ---@field file_pattern string|string[]
  ---@type string | string[]
  --file_pattern = { '*.myconfig' }, -- Glob pattern(s) for file matching

  -- Lua pattern
  ---@field pattern string
  ---@type string
  --pattern = '^%s*@([%w_]+)%s*=%s*(.+)', -- Lua pattern with capture groups

  -- Key capture group (optional)
  ---@field key_capture? number
  ---@type number
  --key_capture = 1, -- Capture group for key (optional)

  -- Value capture group (required)
  ---@field value_capture number
  ---@type number
  --value_capture = 2, -- Capture group for value (required)
}

return custom_patterns
