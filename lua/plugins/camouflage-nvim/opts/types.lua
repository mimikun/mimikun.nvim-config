---@class CamouflageEnvParserConfig
---@field include_commented? boolean
---@field include_export? boolean

---@class CamouflageJsonParserConfig
---@field max_depth? number

---@class CamouflageYamlParserConfig
---@field max_depth? number

---@class CamouflageXmlParserConfig
---@field max_depth? number Maximum nesting depth for XML elements

---@class CamouflageHclParserConfig
---@field max_depth? number Maximum block nesting depth

---@class CamouflageParsersConfig
---@field include_commented? boolean
---@field env? CamouflageEnvParserConfig
---@field json? CamouflageJsonParserConfig
---@field yaml? CamouflageYamlParserConfig
---@field xml? CamouflageXmlParserConfig
---@field hcl? CamouflageHclParserConfig

---@class CamouflageCmpConfig
---@field disable_in_masked? boolean

---@class CamouflageIntegrationsConfig
---@field telescope? boolean
---@field cmp? CamouflageCmpConfig

---@class CamouflageColorsConfig
---@field foreground string|nil Foreground color (hex or color name, nil to use highlight_group)
---@field background string|nil Background color (hex, color name, 'transparent', or nil)
---@field bold boolean|nil Bold text
---@field italic boolean|nil Italic text

---@class CamouflagePatternConfig
---@field file_pattern string|string[]
---@field parser string

---@class CamouflageCustomPatternConfig
---@field file_pattern string|string[]  File pattern (glob)
---@field pattern string                 Lua pattern
---@field key_capture? number            Key capture group (optional)
---@field value_capture number           Value capture group (required)

---@class CamouflageHooksConfig
---@field on_before_decorate? fun(bufnr: number, filename: string): boolean|nil
---@field on_variable_detected? fun(bufnr: number, var: ParsedVariable): boolean|nil
---@field on_after_decorate? fun(bufnr: number, variables: ParsedVariable[]): nil

---@class CamouflageYankConfig
---@field default_register? string Default register ('+' for system clipboard)
---@field notify? boolean Show notification after copy
---@field auto_clear_seconds? number|nil Seconds before auto-clearing clipboard (nil = disabled)
---@field confirm? boolean Require confirmation before copying
---@field confirm_message? string Confirmation message format

---@class CamouflageRevealConfig
---@field highlight_group? string Highlight group for revealed values
---@field notify? boolean Show notification on reveal/hide
---@field follow_cursor? boolean Auto-reveal current line as cursor moves (default: false)

---@class CamouflagePwnedConfig
---@field enabled? boolean Feature toggle (default: true)
---@field auto_check? boolean Check on BufEnter (default: false; network opt-in)
---@field check_on_save? boolean Check on BufWritePost (default: false; network opt-in)
---@field check_on_change? boolean Check on TextChanged with debounce (default: false; network opt-in)
---@field show_sign? boolean Show sign column indicator (default: true)
---@field show_virtual_text? boolean Show virtual text (default: true)
---@field show_line_highlight? boolean Highlight the line (default: true)
---@field sign_text? string Sign icon (default: "!")
---@field sign_hl? string Sign highlight group (default: "DiagnosticWarn")
---@field virtual_text_format? string Virtual text format (default: "PWNED (%s)")
---@field virtual_text_prefix? string Deprecated: prefix for virtual text, use virtual_text_format instead
---@field virtual_text_hl? string Virtual text highlight (default: "DiagnosticWarn")
---@field line_hl? string Line highlight group (default: "CamouflagePwned")

---@class CamouflageExpiryRefreshConfig
---@field on_buf_enter? boolean Re-check on BufEnter (default: true)
---@field on_save? boolean Re-check on BufWritePost (default: true)
---@field on_change? boolean Re-check on TextChanged (debounced) (default: true)
---@field auto_interval? integer Background re-render interval in seconds, 0 disables (default: 60)

---@class CamouflageExpiryConfig
---@field enabled? boolean (default: true)
---@field show_threshold_seconds? integer Show badge only when remaining < this (default: 86400 = 24h)
---@field warn_threshold_seconds? integer Switch badge to warning color when remaining < this (default: 3600 = 1h)
---@field show_provider? boolean Append provider name from `iss` claim (default: true)
---@field refresh? CamouflageExpiryRefreshConfig
---@field hl_valid? string Highlight when token is valid but within show_threshold (default: 'Comment')
---@field hl_warning? string Highlight when within warn_threshold (default: 'DiagnosticWarn')
---@field hl_expired? string Highlight when expired (default: 'DiagnosticError')

---@class CamouflageWeakSecretConfig
---@field enabled? boolean Feature toggle (default: true)
---@field min_length? integer General minimum length used by future heuristics (default: 8)
---@field min_sensitive_length? integer Minimum length for sensitive keys (default: 12)
---@field entropy_threshold? number Shannon entropy threshold for token-like values (default: 3.0)
---@field sensitive_key_patterns? string[] Lua patterns that mark a key as secret-like
---@field ignored_key_patterns? string[] Lua patterns for keys to skip
---@field ignored_value_patterns? string[] Lua patterns for values to skip
---@field common_values? string[] Common/default weak values
---@field show_sign? boolean Show sign column indicator
---@field sign_text? string Sign text
---@field sign_hl? string Sign highlight group
---@field show_virtual_text? boolean Show badge virtual text
---@field virtual_text_format? string Badge text format with one `%s` reason placeholder
---@field virtual_text_hl? string Badge highlight group
---@field line_hl? string|nil Whole-line highlight group

---@class CamouflageBadgesConfig
---@field position? string Where badges render: 'right_align' | 'eol' | 'inline' (default: 'right_align')
---@field separator? string Text inserted between adjacent badges (default: ' ')
---@field separator_hl? string Highlight for the separator (default: 'Comment')

---@class CamouflageAuditConfig
---@field ignore_patterns? string[] Root-relative globs or basename globs skipped by workspace audit
---@field max_files_per_chunk? integer Number of discovered files processed per scheduled async chunk
---@field destination? string "quickfix" | "loclist" (default: "quickfix")
---@field open? boolean Open quickfix/location-list after findings are written
---@field notify? boolean Show audit completion notifications

---@class CamouflagePolicyValueLengthConfig
---@field min? number
---@field max? number

---@class CamouflagePolicyRuleConfig
---@field id? string Stable rule identifier for status/debug metadata
---@field action string "mask" | "ignore"
---@field allow_force? boolean Allow this mask rule to override broader ignore rules
---@field path? string|string[] Root-relative glob(s)
---@field basename? string|string[] Basename glob(s)
---@field parser? string|string[] Parser name(s)
---@field key? string|string[] Lua pattern(s) matched against parsed keys
---@field nested? boolean Match nested parser output
---@field commented? boolean Match commented parser output
---@field value_length? CamouflagePolicyValueLengthConfig
---@field value_shape? string|string[] "empty" | "non_empty" | "numeric" | "boolean" | "quoted" | "jwt_like" | "token_like"
---@field value_prefix? string|string[] Literal value prefix shape(s), never logged
---@field value_suffix? string|string[] Literal value suffix shape(s), never logged

---@class CamouflagePolicyConfig
---@field enabled? boolean Enable declarative policy evaluation
---@field default_action? string "mask" | "ignore" for unmatched parsed variables
---@field terminal_path_ignores? string[] Root-relative globs ignored before ordered rules unless allow_force mask matches
---@field rules? CamouflagePolicyRuleConfig[] Ordered policy rules

---@class CamouflageChecksConfig
---@field badges? CamouflageBadgesConfig
---@field pwned? CamouflagePwnedConfig
---@field expiry? CamouflageExpiryConfig
---@field weak_secret? CamouflageWeakSecretConfig
--- Registered public checks can also read data-only options from
--- `checks.<name>`, including `enabled`.

---@class CamouflageProjectConfigLoaderConfig
---@field enabled? boolean Enable repo config loading (default: true)
---@field filename? string Project config filename (default: ".camouflage.yaml")
---@field notify? boolean Show warnings for project config parse/validation issues (default: true)
---@field secure? boolean Gate the project file behind vim.secure.read / :trust (default: false)
---@field watch_enabled? boolean Watch .camouflage.yaml for runtime changes (default: true)
---@field watch_backend? string "auto" | "autocmd" | "fs" | "both" (default: "auto")
---@field watch_debounce_ms? number Debounce for change events (default: 200)
---@field max_watched_roots? number Max roots to watch in one session (default: 10)
---@field notify_on_reload? boolean Show info notification after successful live reload (default: false)
