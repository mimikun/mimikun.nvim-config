local messages = {
  -- NOTE: If you enable messages, then the cmdline is enabled automatically.
  -- This is a current Neovim limitation.

  -- enables the Noice messages UI
  enabled = true,

  -- default view for messages
  view = "notify",

  -- view for errors
  view_error = "notify",

  -- view for warnings
  view_warn = "notify",

  -- view for :messages
  view_history = "messages",

  -- view for search count messages.
  -- Set to `false` to disable
  view_search = "virtualtext",
}

return messages
