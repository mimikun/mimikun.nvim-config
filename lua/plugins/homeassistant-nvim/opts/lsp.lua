local host
host = os.getenv("HOMEASSISTANT_HOST")
host = "ws://homeassistant.local:8123/api/websocket"

local token = os.getenv("HOMEASSISTANT_TOKEN")

---@type table
local lsp = {
  enabled = true,

  -- LSP server command (default: homeassistant-lsp --stdio)
  cmd = {
    "homeassistant-lsp",
    "--stdio",
  },

  -- File types to attach LSP to
  filetypes = {
    "yaml",
    "yaml.homeassistant",
    "python",
    "json",
  },

  -- Auto-detect root directory (uses lspconfig.util.root_pattern)
  root_dir = nil,

  -- LSP server settings
  settings = {
    homeassistant = {
      host = host,
      token = token,
      timeout = 5000,
    },
    cache = {
      enabled = true,

      -- 5 minutes
      ttl = 300,
    },
    diagnostics = {
      enabled = true,
      debounce = 500,
    },
    completion = {
      -- Minimum characters for domain completion
      minChars = 3,
    },
  },
}

return lsp
