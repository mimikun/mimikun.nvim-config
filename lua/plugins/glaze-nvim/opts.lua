---@type GlazeConfig
local opts = {
  ---@type GlazeUIConfig
  ui = {
    ---@type string | "none" | "single" | "double" | "rounded" | "solid" | "shadow"
    border = "rounded",
    ---@type { width: number, height: number }
    size = {
      width = 0.7,
      height = 0.8,
    },
    ---@type GlazeIcons
    icons = {
      ---@type string
      pending = "○",
      ---@type string
      running = "◐",
      ---@type string
      done = "●",
      ---@type string
      error = "✗",
      ---@type string
      binary = "󰆍",
    },
    -- Use nvim highlight groups instead of doughnut colors
    ---@type boolean
    use_system_theming = false,
  },

  -- Parallel installations
  ---@type number
  concurrency = 4,

  -- Go command (auto-detects goenv)
  ---@type string[]
  go_cmd = {
    "go",
  },

  -- Auto-install missing binaries on register
  ---@type GlazeAutoInstallConfig
  auto_install = {
    -- Whether to auto-install missing binaries on register
    ---@type boolean
    enabled = true,
    -- Suppress notifications during auto-install
    ---@type boolean
    silent = false,
  },

  -- Auto-check for updates
  ---@type GlazeAutoCheckConfig
  auto_check = {
    -- Whether to auto-check for updates
    ---@type boolean
    enabled = true,
    -- "daily", "weekly", or hours as number
    ---@type string | number | "daily" | "weekly"
    frequency = "daily",
  },

  -- Auto-update when newer versions found
  ---@type GlazeAutoUpdateConfig
  auto_update = {
    -- Whether to auto-update binaries when newer versions are found (requires auto_check)
    ---@type boolean
    enabled = false,
  },
}

return opts
