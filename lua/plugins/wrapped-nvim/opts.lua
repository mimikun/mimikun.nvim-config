---@type WrappedConfig
local opts = {
  ---@type string | nil
  path = vim.fn.stdpath("config"),

  ---@type boolean |string | string[]
  border = false,

  ---@type { width: integer, height: integer }
  size = {
    ---@type integer
    width = 120,

    ---@type integer
    height = 40,
  },

  ---@type string[]
  exclude_filetype = {
    ".gitmodules",
  },

  ---@type { commits: integer, plugins: integer, plugins_ever: integer, lines: integer }
  cap = {
    ---@type integer
    commits = 1000,

    ---@type integer
    plugins = 100,

    ---@type integer
    plugins_ever = 200,

    ---@type integer
    lines = 10000,
  },
}

return opts
