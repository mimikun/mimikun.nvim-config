-- Declarative data-only masking policy
---@type CamouflagePolicyConfig
local policy = {
  -- Enable declarative policy evaluation
  ---@type boolean
  enabled = true,

  -- for unmatched parsed variables
  ---@type string | "mask" | "ignore"
  default_action = "mask",

  -- Root-relative globs ignored before ordered rules unless allow_force mask matches
  ---@type string[]
  terminal_path_ignores = {
    "node_modules/**",
    ".git/**",
  },

  -- Ordered policy rules
  ---@type CamouflagePolicyRuleConfig[]
  rules = {
    {
      id = "ignore-debug-flags",
      action = "ignore",
      key = {
        "^DEBUG$",
        "^PORT$",
      },
      parser = {
        "env",
        "json",
        "yaml",
      },
    },
    {
      id = "force-client-secrets",
      action = "mask",
      allow_force = true,
      key = {
        "client[_%.%-]?secret",
        "private[_%.%-]?key",
      },
    },
  },
}

return policy
