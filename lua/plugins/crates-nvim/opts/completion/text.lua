---@type crates.UserCompletionTextConfig
local text

---@type crates.UserCompletionTextConfig
local plain = {
  ---@type string
  prerelease = " pre-release ",

  ---@type string
  yanked = " yanked ",
}

---@type crates.UserCompletionTextConfig
local rich = {
  ---@type string
  prerelease = "  pre-release ",

  ---@type string
  yanked = "  yanked ",
}

text = rich

return text
