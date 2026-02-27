---@type WrappedConfig
local opts = {
  ---@type string|nil
  path = vim.fn.stdpath("config"),
  ---@type boolean|string|string[]
  border = false,
  ---@type size { width: integer, height: integer }
  size = {
    width = 120,
    height = 40,
  },
  ---@type string[]
  exclude_filetype = {
    ".gitmodules",
  },
  ---@type { commits: integer, plugins: integer, plugins_ever: integer, lines: integer }
  cap = {
    commits = 1000,
    plugins = 100,
    plugins_ever = 200,
    lines = 10000,
  },
}

return opts
