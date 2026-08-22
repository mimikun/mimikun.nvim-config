---@type CodesettingsConfig
local opts = {
  -- Files searched under the project root, in order.
  ---@type string[]
  config_file_paths = {
    ".vscode/settings.json",
    "codesettings.json",
    "lspsettings.json",
  },

  -- Open the files above as jsonc (comments + trailing commas).
  ---@type boolean
  jsonc_filetype = true,

  -- Schema-driven completion inside the settings files via jsonls.
  ---@type boolean
  jsonls_integration = true,

  -- Push `workspace/didChangeConfiguration` when a settings file is written, so edits apply without restarting Neovim.
  ---@type boolean
  live_reload = true,

  -- Post-processing applied while loading.
  -- The VS Code variable interpolation extension (`${workspaceFolder}` and friends) is the upstream default and must be listed explicitly once this key is set.
  ---@type (string | CodesettingsLoaderExtension | fun():CodesettingsLoaderExtension)[]
  loader_extensions = {
    "codesettings.extensions.vscode",
  },

  -- Let lua_ls/emmylua_ls see the generated type annotations.
  ---@type boolean | (fun():boolean)
  lua_ls_integration = true,

  -- Local lists extend the global ones instead of replacing them.
  ---@type CodesettingsMergeListsBehavior
  merge_lists = "append",

  -- Substitute placeholder strings in schema descriptions with the bundled English NLS files.
  ---@type boolean | string | table | (fun(string):table)
  nls = true,

  -- nil => `require('codesettings.util').get_root()`
  ---@type string | (fun():string) | nil
  root_dir = nil,
}

return opts
