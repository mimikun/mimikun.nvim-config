---@type Hover.UserConfig
local opts = {
  -- List of modules names to load as providers.
  ---@type (string | Hover.Config.Provider)[]
  providers = require("plugins.hover-nvim.opts.providers"),

  ---@type vim.api.keyset.win_config
  preview_opts = {
    border = "single",
  },

  -- Whether the contents of a currently open hover window should be moved to a :h preview-window when pressing the hover keymap.
  ---@type boolean
  preview_window = false,

  ---@type boolean
  title = true,

  -- List of modules names to load as providers for the hover window created by `require('hover').mouse()`.
  ---@type string[]
  mouse_providers = {
    "hover.providers.lsp",
  },

  ---@type integer
  mouse_delay = 1000,
}

return opts
