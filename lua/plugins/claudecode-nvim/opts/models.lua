---@type ClaudeCodeModelOption[]
local models = {
  {
    name = "Claude Opus (Latest)",
    value = "opus",
  },
  {
    name = "Claude Opus (Latest, 1M context)",
    value = "opus[1m]",
  },
  {
    name = "Claude Sonnet (Latest)",
    value = "sonnet",
  },
  {
    name = "Claude Sonnet (Latest, 1M context)",
    value = "sonnet[1m]",
  },
  {
    name = "Claude Haiku (Latest)",
    value = "haiku",
  },
  {
    name = "Default (account recommended)",
    value = "default",
  },
}

return models
