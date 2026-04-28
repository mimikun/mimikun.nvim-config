---@type crates.UserTextConfig
local text

---@type crates.UserTextConfig
local plain = {
  ---@type string
  loading = "  Loading...",

  ---@type string
  version = "  %s",

  ---@type string
  prerelease = "  %s",

  ---@type string
  yanked = "  %s yanked",

  ---@type string
  nomatch = "  Not found",

  ---@type string
  upgrade = "  %s",

  ---@type string
  error = "  Error fetching crate",
}

---@type crates.UserTextConfig
local rich = {
  ---@type string
  searching = "   Searching",

  ---@type string
  loading = "   Loading",

  ---@type string
  version = "   %s",

  ---@type string
  prerelease = "   %s",

  ---@type string
  yanked = "   %s",

  ---@type string
  nomatch = "   No match",

  ---@type string
  upgrade = "   %s",

  ---@type string
  error = "   Error fetching crate",
}

text = rich

return text
