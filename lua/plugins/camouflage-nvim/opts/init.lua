---@field enabled? boolean
---@field debug? boolean Enable debug logging (default: false)
---@field auto_enable? boolean
---@field debounce_ms? number Debounce delay in ms for TextChanged masking (default: 150, 0 = instant)
---@field style? string
---@field mask_char? string
---@field mask_length? number|nil
---@field max_lines? number|nil
---@field hidden_text? string
---@field highlight_group? string
---@field colors? CamouflageColorsConfig|nil
---@field patterns? CamouflagePatternConfig[]
---@field parsers? CamouflageParsersConfig
---@field integrations? CamouflageIntegrationsConfig
---@field hooks? CamouflageHooksConfig|nil
---@field yank? CamouflageYankConfig|nil Yank configuration
---@field reveal? CamouflageRevealConfig|nil Reveal configuration
---@field pwned? CamouflagePwnedConfig Pwned passwords check configuration
---@field custom_patterns? CamouflageCustomPatternConfig[] Custom patterns for unsupported file types
---@field project_config? CamouflageProjectConfigLoaderConfig Repo-level project config loading
---@field audit? CamouflageAuditConfig Workspace audit configuration
---@field policy? CamouflagePolicyConfig Declarative data-only masking policy
---@field checks? CamouflageChecksConfig Per-check configuration (pwned, expiry, ...)

---@type CamouflageConfig
local opts = {}

return opts
