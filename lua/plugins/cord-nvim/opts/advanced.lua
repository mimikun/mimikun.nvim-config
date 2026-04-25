-- Advanced configuration
---@type CordAdvancedConfig
local advanced = {
  ---@type CordAdvancedPluginConfig
  plugin = {
    -- Whether to enable autocmds
    ---@type boolean
    autocmds = true,

    -- Cursor update mode
    ---@type string
    cursor_update = "on_hold",

    -- Whether to match against file extensions in mappings
    ---@type boolean
    match_in_mappings = true,

    -- Debounce/throttle configuration for activity updates
    ---@type CordAdvancedDebounceConfig
    debounce = {
      -- Delay in milliseconds before sending the first update.
      -- Allows events received in quick succession (e.g., buffer switches) to settle before sending data.
      -- Set to 0 to disable.
      ---@type integer
      delay = 50,

      -- Minimum interval in milliseconds between updates.
      -- Prevents flooding the server during rapid cursor movement.
      -- Set to 0 to disable.
      ---@type integer
      interval = 750,
    },
  },

  ---@type CordAdvancedServerConfig
  server = {
    -- How to acquire the server executable
    ---@type string | "fetch" | "install" | "build" | "none"
    update = "fetch",

    -- Whether to auto-update the server executable (when using the "fetch" strategy)
    ---@type boolean
    auto_update = false,

    -- Path to the server"s pipe
    ---@type string
    pipe_path = nil,

    -- Path to the server"s executable
    ---@type string
    executable_path = nil,

    -- Timeout in milliseconds
    ---@type integer
    timeout = 300000,
  },

  ---@type CordAdvancedDiscordConfig
  discord = {
    -- Custom IPC pipe paths to use when connecting to Discord
    ---@type string[]
    pipe_paths = nil,

    -- Reconnection settings
    ---@type CordAdvancedDiscordReconnectConfig
    reconnect = {
      -- Whether reconnection is enabled
      ---@type boolean
      enabled = false,

      -- Reconnection interval in milliseconds, 0 to disable
      ---@type integer
      interval = 5000,

      -- Whether to reconnect if initial connection fails
      ---@type boolean
      initial = true,
    },

    -- Synchronization settings
    ---@type CordAdvancedSyncConfig
    sync = {
      -- Whether synchronization logic is enabled
      ---@type boolean
      enabled = true,

      -- Synchronization mode
      ---@type string | "periodic" | "defer"
      mode = "periodic",

      -- Interval in milliseconds
      ---@type integer
      interval = 12000,

      -- Whether to reset periodic synchronization on activity updates
      ---@type boolean
      reset_on_update = true,

      -- Whether to pad activity fields
      ---@type boolean
      pad = true,
    },
  },

  ---@type CordAdvancedWorkspaceConfig
  workspace = {
    ---Root markers to use for finding workspaces
    ---@type string[]
    root_markers = {
      ".git",
      ".hg",
      ".svn",
    },

    -- Whether to limit workspace detection to the working directory (vim.fn.getcwd()).
    -- When true, workspace detection stops at the CWD if no marker is found.
    ---@type boolean
    limit_to_cwd = false,
  },
}

return advanced
