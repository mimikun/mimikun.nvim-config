local diagnostics = {
  ---@type string | 'buffer' | 'workspace'
  scope = "buffer",
  -- Diagnostic severity filter (see Neovim `:help diagnostic-severity`)
  severity = {
    min = vim.diagnostic.severity.WARN,
  },
  -- Whether to override default text configurations (recommended: true)
  override = true,
}

local resolver = {
  sources = {
    nestjs = false,
    toggleterm = false,
    oil = false,
  },
}

local local_time = {
  affect_idle = true,
}

local persistent_timer = {
  ---@type string | "workspace" | "file" | "filetype" | "global"
  scope = "workspace",

  ---@type string | "all" | "active" | "idle"
  mode = "all",

  -- Path to the timer data file
  file = vim.fn.stdpath("data") .. "/cord/extensions/persistent_timer/data.json",

  -- Events that trigger a save
  save_on = {
    "exit",
    "focus_change",
    "periodic",
  },

  -- Interval in seconds for periodic saves
  save_interval = 30,
}

local scoped_timestamps = {
  ---@type string | "buffer" | "workspace" | "idle"
  scope = "buffer",

  pause = true,
}

-- Extension configuration
---@type string[] | table<string, table>[]
local extensions = {
  diagnostics = diagnostics,
  resolver = resolver,
  local_time = local_time,
  persistent_timer = persistent_timer,
  scoped_timestamps = scoped_timestamps,
}

extensions = nil

return extensions
