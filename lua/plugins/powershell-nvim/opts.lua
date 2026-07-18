---@alias powershell.LogLevel "Trace" | "Debug" | "Information" | "Warning" | "Error" | "Critical" | "None"

---@type powershell.user_config
local opts = {
  ---@type string | nil
  shell = "pwsh",

  ---@type string
  bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",

  ---@type string[] | nil
  feature_flags = {},

  ---@type powershell.LogLevel | nil
  lsp_log_level = "Warning",

  ---@type lsp.ClientCapabilities | nil
  capabilities = vim.lsp.protocol.make_client_capabilities(),

  ---@type table<string, any> | nil
  init_options = {},

  ---@type powershell.lsp_settings | nil
  settings = {},

  -- see lua/powershell/handlers.lua
  ---@type table<string, powershell.handler> | nil
  handlers = nil,
  --handlers = base_handlers,

  -- see lua/powershell/commands.lua
  --commands = base_commands,
  commands = nil,

  ---@type function | nil
  on_attach = function()
    return nil
  end,

  ---@type fun(buf: integer): string | nil
  root_dir = function(buf)
    local current_file_dir = fs.dirname(api.nvim_buf_get_name(buf))
    return fs.dirname(fs.find({ ".git" }, { upward = true, path = current_file_dir })[1]) or current_file_dir
  end,
}

return opts
