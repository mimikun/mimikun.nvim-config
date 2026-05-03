-- Path-based loading (recommended if you only work with HA files in specific directories):
-- Only initialize when files match these paths
-- If nil or empty, plugin loads on all files (default behavior)
-- If set to array of patterns, plugin only loads when file path matches any pattern
-- Patterns are Lua patterns (see :help pattern)
---@type table
local paths = {
  "config/homeassistant/",
  --"~/dotfiles/",
  --"/homeassistant/",
  --"%.yaml$",
  -- Use %- to match literal -
  --"home%-assistant%-config/",
}

return paths
