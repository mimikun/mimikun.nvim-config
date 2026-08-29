-- Registered public checks can also read data-only options from `checks.<name>`, including `enabled`.

-- Per-check configuration (pwned, expiry, ...)
---@type CamouflageChecksConfig
local checks = {
  ---@type CamouflageBadgesConfig
  badges = {
    -- Where badges render:
    ---@type string | "right_align" | "eol" | "inline"
    position = "right_align",

    -- Text inserted between adjacent badges
    ---@type string | " "
    separator = " ",

    -- Highlight for the separator
    ---@type string | "Comment"
    separator_hl = "Comment",
  },

  ---@type CamouflageExpiryConfig
  expiry = {
    ---@type boolean
    enabled = true,

    -- Show badge only when remaining < this (default: 86400 = 24h)
    ---@type integer
    show_threshold_seconds = 86400,

    -- Switch badge to warning color when remaining < this (default: 3600 = 1h)
    ---@type integer
    warn_threshold_seconds = 3600,

    -- Append provider name from `iss` claim (default: true)
    ---@type boolean
    show_provider = true,

    ---@type CamouflageExpiryRefreshConfig
    refresh = {
      -- Re-check on BufEnter
      ---@type boolean | true
      on_buf_enter = true,

      -- Re-check on BufWritePost
      ---@type boolean | true
      on_save = true,

      -- Re-check on TextChanged (debounced)
      ---@type boolean | true
      on_change = true,

      -- Background re-render interval in seconds, 0 disables
      ---@type integer | 60
      auto_interval = 60,
    },

    -- Highlight when token is valid but within show_threshold
    ---@type string | "Comment"
    hl_valid = "Comment",

    -- Highlight when within warn_threshold
    ---@type string | "DiagnosticWarn"
    hl_warning = "DiagnosticWarn",

    -- Highlight when expired
    ---@type string | "DiagnosticError"
    hl_expired = "DiagnosticError",
  },

  ---@type CamouflageWeakSecretConfig
  weak_secret = {

    -- Feature toggle
    ---@type boolean | true
    enabled = true,

    -- General minimum length used by future heuristics
    ---@type integer | 8
    min_length = 8,

    -- Minimum length for sensitive keys
    ---@type integer | 12
    min_sensitive_length = 12,

    -- Shannon entropy threshold for token-like values
    ---@type number | 3.0
    entropy_threshold = 3.0,

    -- Lua patterns that mark a key as secret-like
    ---@type string[]
    sensitive_key_patterns = {
      "password",
      "passwd",
      "passphrase",
      "secret",
      "token",
      "api[_%-]*key",
      "access[_%-]*key",
      "private[_%-]*key",
      "client[_%-]*secret",
      "auth[_%-]*token",
      "credential",
    },

    -- Lua patterns for keys to skip
    ---@type string[]
    ignored_key_patterns = {
      --it
    },

    -- Lua patterns for values to skip
    ---@type string[]
    ignored_value_patterns = {
      --it
    },

    -- Common/default weak values
    ---@type string[]
    common_values = {
      "password",
      "password1",
      "password123",
      "secret",
      "secret123",
      "changeme",
      "changeit",
      "admin",
      "default",
      "test",
      "testing",
      "demo",
      "dummy",
      "qwerty",
      "letmein",
      "welcome",
      "hunter2",
    },

    -- Show sign column indicator
    ---@type boolean
    show_sign = false,

    -- Sign text
    ---@type string
    sign_text = "!",

    -- Sign highlight group
    ---@type string
    sign_hl = "DiagnosticWarn",

    -- Show badge virtual text
    ---@type boolean
    show_virtual_text = true,

    -- Badge text format with one `%s` reason placeholder
    ---@type string
    virtual_text_format = "[weak: %s]",

    -- Badge highlight group
    ---@type string
    virtual_text_hl = "DiagnosticWarn",

    -- Whole-line highlight group
    ---@type string | nil
    line_hl = nil,
  },
}

return checks
