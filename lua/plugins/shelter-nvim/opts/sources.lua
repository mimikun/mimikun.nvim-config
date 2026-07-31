-- Source file-based mode selection
-- Source file patterns to mode mapping
---@type table<string, string>
local sources = {
  -- Don't mask local dev file
  [".env.local"] = "none",
  [".env.*.local"] = "none",

  -- Full mask for production
  [".env.production"] = "full",
}

return sources
