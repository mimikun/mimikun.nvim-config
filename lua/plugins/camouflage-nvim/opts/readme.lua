local readme = {
  enabled = true,
  auto_enable = true,
  style = "stars", -- 'text' | 'dotted' | 'stars' | 'scramble'
  mask_char = "*",
  debounce_ms = 150,
  max_lines = 5000,

  audit = {
    ignore_patterns = { ".git/**", "node_modules/**" },
    destination = "quickfix", -- 'quickfix' | 'loclist'
  },

  policy = {
    enabled = true,
    default_action = "mask",
    terminal_path_ignores = { "node_modules/**", ".git/**" },
    rules = {
      {
        id = "ignore-debug-flags",
        action = "ignore",
        key = { "^DEBUG$", "^PORT$" },
        parser = { "env", "json", "yaml" },
      },
      {
        id = "force-client-secrets",
        action = "mask",
        allow_force = true,
        key = { "client[_%.%-]?secret", "private[_%.%-]?key" },
      },
    },
  },

  checks = {
    weak_secret = {
      enabled = true,
      min_sensitive_length = 12,
      entropy_threshold = 3.0,
      ignored_key_patterns = {},
      ignored_value_patterns = {},
    },
  },

  pwned = {
    enabled = true, -- Manual HIBP commands are available
    auto_check = false, -- Network check on BufEnter (opt in)
    check_on_save = false, -- Network check on BufWritePost (opt in)
    check_on_change = false, -- Network check on TextChanged (opt in)
  },

  reveal = {
    follow_cursor = false, -- Auto-reveal current line
  },

  yank = {
    confirm = true, -- Require confirmation before copying
    auto_clear_seconds = 30, -- Auto-clear clipboard
  },

  integrations = {
    telescope = true,
    cmp = { disable_in_masked = true },
  },
}
