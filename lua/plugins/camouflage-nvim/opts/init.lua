---@type CamouflageConfig
local opts = {
  ---@type boolean
  enabled = true,

  -- Enable debug logging (default: false)
  ---@type boolean
  debug = false,

  -- Automatically mask on file open
  ---@type boolean
  auto_enable = true,

  -- Debounce delay in ms for TextChanged masking (default: 150, 0 = instant)
  ---@type number
  debounce_ms = 150,

  ---@type string | "text" | "dotted" | "stars" | "scramble"
  style = "stars",

  ---@type string
  mask_char = "*",

  ---@type number | nil
  mask_length = nil,

  ---@type number | nil
  max_lines = 5000,

  ---@type string
  hidden_text = "************************",

  ---@type string
  highlight_group = "Comment",

  -- Custom colors override highlight_group:
  ---@type CamouflageColorsConfig | nil
  colors = require("plugins.camouflage-nvim.opts.colors"),

  ---@type CamouflagePatternConfig[]
  patterns = require("plugins.camouflage-nvim.opts.patterns"),

  ---@type CamouflageParsersConfig
  parsers = require("plugins.camouflage-nvim.opts.parsers"),

  ---@type CamouflageIntegrationsConfig
  integrations = require("plugins.camouflage-nvim.opts.integrations"),

  ---@type CamouflageHooksConfig | nil
  hooks = require("plugins.camouflage-nvim.opts.hooks"),

  -- Yank configuration
  ---@type CamouflageYankConfig | nil
  yank = require("plugins.camouflage-nvim.opts.yank"),

  -- Reveal configuration
  ---@type CamouflageRevealConfig | nil
  reveal = require("plugins.camouflage-nvim.opts.reveal"),

  -- Pwned passwords check configuration
  ---@type CamouflagePwnedConfig
  pwned = require("plugins.camouflage-nvim.opts.pwned"),

  -- Custom patterns for unsupported file types
  ---@type CamouflageCustomPatternConfig[]
  custom_patterns = require("plugins.camouflage-nvim.opts.custom_patterns"),

  -- Repo-level project config loading
  ---@type CamouflageProjectConfigLoaderConfig
  project_config = require("plugins.camouflage-nvim.opts.project_config"),

  -- Workspace audit configuration
  ---@type CamouflageAuditConfig
  audit = require("plugins.camouflage-nvim.opts.audit"),

  -- Declarative data-only masking policy
  ---@type CamouflagePolicyConfig
  policy = require("plugins.camouflage-nvim.opts.policy"),

  -- Per-check configuration (pwned, expiry, ...)
  ---@type CamouflageChecksConfig
  checks = require("plugins.camouflage-nvim.opts.checks"),
}

return opts
