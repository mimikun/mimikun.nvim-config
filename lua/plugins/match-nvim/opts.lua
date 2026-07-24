---@class MatchOpts
local opts = {
  ---@type string
  prefix = "",

  ---@type string | "NE" | "NW" | "SE" | "SW"
  anchor = "NE",

  ---@type string | "minimal"
  style = "minimal",

  ---@type string
  border = "rounded",

  ---@type string
  border_hl = "Function",
}

return opts
