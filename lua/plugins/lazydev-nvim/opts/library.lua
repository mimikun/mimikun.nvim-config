---@type lazydev.Library.spec[]
local library = {
  -- Or relative, which means they will be resolved from the plugin dir.
  "lazy.nvim",

  -- It can also be a table with trigger words / mods
  -- Only load luvit types when the `vim.uv` word is found
  {
    path = "${3rd}/luv/library",
    words = {
      "vim%.uv",
    },
  },

  -- Load the wezterm types when the `wezterm` module is required
  -- Needs `DrKJeff16/wezterm-types` to be installed
  {
    path = "wezterm-types",
    mods = {
      "wezterm",
    },
  },

  -- Load the xmake types when opening file named `xmake.lua`
  -- Needs `LelouchHe/xmake-luals-addon` to be installed
  {
    path = "xmake-luals-addon/library",
    files = {
      "xmake.lua",
    },
  },
}

return library
