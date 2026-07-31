-- Pattern-based mode selection
-- Key patterns to mode mapping
---@type table<string, string>
local patterns = {
  -- Full mask for API keys
  -- API_KEY, SECRET_KEY
  ["*_KEY"] = "full",

  -- Don't mask public values
  -- PUBLIC_KEY, MY_PUBLIC_VAR
  ["*_PUBLIC*"] = "none",

  -- Don't mask debug flags
  -- Exact match
  ["DEBUG"] = "none",

  -- Custom Modes
  ["*_TOKEN"] = "truncate",

  -- DB_HOST, DB_PASSWORD
  ["DB_*"] = "partial",
}

return patterns
