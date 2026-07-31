---@alias EcologLspBackend
---| "auto"      # Auto-detect best approach (default)
---| "native"    # Force vim.lsp.config (Neovim 0.11+)
---| "lspconfig" # Force nvim-lspconfig
---| false       # External management (hooks only)

-- LSP configuration
---@type EcologLspConfig
local lsp = {
  -- LSP setup backend
  ---@type EcologLspBackend | "auto" | "native" | "lspconfig" | false
  backend = "auto",

  -- Client name for external mode matching
  -- Client name to match when backend=false (default: "ecolog")
  ---@type string
  client = "ecolog",

  -- Binary path (auto-detected if nil)
  -- LSP command (default: auto-detect)
  ---@type string | string[]
  cmd = nil,

  -- Filetypes to attach (nil = all buffers)
  ---@type string[]
  filetypes = nil,

  -- Workspace root (nil = cwd)
  -- Workspace root directory (default: cwd)
  ---@type string
  root_dir = nil,

  -- Patterns for env file watching
  -- File patterns for env files (used for file watching)
  ---@type string[]
  env_patterns = {
    "*.env",
    ".env.*",
  },

  -- Additional LSP settings to send to server
  ---@type table
  settings = {
    --it
  },

  -- Feature toggles (sent to LSP, merged with ecolog.toml)
  ---@type EcologFeatureConfig
  features = {
    -- Enable hover (default: true)
    ---@type boolean
    hover = true,

    -- Enable completion (default: true)
    ---@type boolean
    completion = true,

    -- Enable diagnostics (default: true)
    ---@type boolean
    diagnostics = true,

    -- Enable go-to-definition (default: true)
    ---@type boolean
    definition = true,
  },

  -- Strict mode: only show features in valid contexts
  -- Strict mode settings (merged with ecolog.toml)
  ---@type EcologStrictConfig
  strict = {
    -- Only hover on valid env var references
    -- Strict hover mode (default: true)
    ---@type boolean
    hover = true,

    -- Only complete after env object access
    -- Strict completion mode (default: true)
    ---@type boolean
    completion = true,
  },

  -- LSP initialization options (interpolation, features, etc.)
  ---@type table
  init_options = {
    interpolation = {
      -- Enable ${VAR} expansion
      ---@type boolean
      enabled = true,
    },
  },

  -- Source configuration (defaults, etc.)
  ---@type EcologSourcesConfig
  sources = {
    -- Default enable states for sources
    ---@type EcologSourceDefaults
    defaults = {
      -- Enable Shell source by default (default: true)
      ---@type boolean
      shell = true,

      -- Enable File source by default (default: true)
      ---@type boolean
      file = true,

      -- Enable Remote source by default (default: false)
      ---@type boolean
      remote = false,
    },
  },

  -- External provider configuration
  ---@type EcologProvidersConfig
  providers = {
    -- Directory containing provider binaries (default: ~/.local/share/ecolog/providers)
    ---@type string
    path = vim.fn.expand("~/.local/share/ecolog/providers"),

    -- Doppler provider config
    ---@type EcologProviderConfig
    doppler = {
      -- Enable this provider (default: false)
      ---@type boolean
      --enabled = true,

      -- Override binary path for this provider
      ---@type string
      --binary = "",
    },

    -- AWS Secrets Manager provider config
    ---@type EcologProviderConfig
    aws = {
      -- Enable this provider (default: false)
      ---@type boolean
      --enabled = true,

      -- Override binary path for this provider
      ---@type string
      --binary = "",
    },

    -- HashiCorp Vault provider config
    ---@type EcologProviderConfig
    vault = {
      -- Enable this provider (default: false)
      ---@type boolean
      --enabled = true,

      -- Override binary path for this provider
      ---@type string
      --binary = "",
    },

    -- Infisical provider config
    ---@type EcologProviderConfig
    infisical = {
      -- Enable this provider (default: false)
      ---@type boolean
      --enabled = true,

      -- Override binary path for this provider
      ---@type string
      --binary = "",
    },
  },
}

return lsp
