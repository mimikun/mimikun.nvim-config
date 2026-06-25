---@type JuuUserConfig
local opts = {
  -- Notification system (enabled by default, set to false to disable)
  ---@type JuuNotifyUserConfig | false | nil
  notify = require("plugins.juu-nvim.opts.notify"),

  -- LSP progress tracking (enabled by default, set to false to disable)
  progress = require("plugins.juu-nvim.opts.progress"),

  -- Floating cmdline (Neovim 0.12+ ui2). Set to false to disable.
  ---@type JuuCmdlineConfig | false | nil
  cmdline = require("plugins.juu-nvim.opts.cmdline"),

  -- Redirect editor messages (e.g. :write) to juu.notify. Requires notify.
  -- Set to false to disable. Disabled automatically if noice.nvim is loaded.
  ---@type JuuMessagesConfig | false | nil
  messages = require("plugins.juu-nvim.opts.messages"),

  -- Input styling configuration
  ---@type table | nil
  input = require("plugins.juu-nvim.opts.input"),

  -- Configuration for vim.ui.select
  ---@type table | nil
  select = require("plugins.juu-nvim.opts.select"),
}

return opts
