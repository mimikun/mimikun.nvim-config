---@type CordConfig
local opts = {
  -- Whether Cord plugin is enabled
  ---@type boolean
  enabled = true,

  -- Log level (from `vim.log.levels`)
  ---@type string | integer
  log_level = vim.log.levels.OFF,

  -- Editor configuration
  ---@type CordEditorConfig
  editor = require("plugins.cord-nvim.opts.editor"),

  -- Display configuration
  ---@type CordDisplayConfig
  display = require("plugins.cord-nvim.opts.display"),

  -- Timestamp configuration
  ---@type CordTimestampConfig
  timestamp = require("plugins.cord-nvim.opts.timestamp"),

  -- Idle configuration
  ---@type CordIdleConfig
  idle = require("plugins.cord-nvim.opts.idle"),

  -- Text configuration
  ---@type CordTextConfig
  text = require("plugins.cord-nvim.opts.text"),

  -- Buttons configuration
  ---@type CordButtonConfig[]
  buttons = require("plugins.cord-nvim.opts.buttons"),

  -- Assets configuration
  ---@type CordAssetConfig[]
  assets = require("plugins.cord-nvim.opts.assets"),

  -- Variables configuration.
  -- If true, uses default options table.
  -- If table, extends default table.
  -- If false, disables custom variables.
  ---@type boolean | CordVariablesConfig
  variables = require("plugins.cord-nvim.opts.variables"),

  -- Hooks configuration
  ---@type CordHooksConfig
  hooks = require("plugins.cord-nvim.opts.hooks"),

  -- Extension configuration
  ---@type string[] | table<string, table>[]
  extensions = require("plugins.cord-nvim.opts.extensions"),

  -- Advanced configuration
  ---@type CordAdvancedConfig
  advanced = require("plugins.cord-nvim.opts.advanced"),
}

return opts
