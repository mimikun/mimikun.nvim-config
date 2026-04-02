---@type lazydev.Config
local opts = {
  runtime = vim.env.VIMRUNTIME,
  ---@type lazydev.Library.spec[]
  library = {
    -- Or relative, which means they will be resolved from the plugin dir.
    "lazy.nvim",
    -- It can also be a table with trigger words / mods
    -- Only load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    -- Load the wezterm types when the `wezterm` module is required
    -- Needs `DrKJeff16/wezterm-types` to be installed
    { path = "wezterm-types", mods = { "wezterm" } },
    -- Load the xmake types when opening file named `xmake.lua`
    -- Needs `LelouchHe/xmake-luals-addon` to be installed
    { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
  },
  integrations = {
    -- Fixes vim.lsp.config workspace management for LuaLS
    -- Only create a new workspace if the buffer is not part
    -- of an existing workspace or one of its libraries.
    -- Only works on Neovim 0.11+.
    lspconfig = true,
    -- add the cmp source for completion of:
    -- `require "modname"`
    -- `---@module "modname"`
    cmp = true,
    -- same, but for Coq
    coq = false,
  },
  -- always enable unless `vim.g.lazydev_enabled = false`
  ---@type boolean|(fun(root:string):boolean?)
  enabled = function(root_dir)
    return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
  end,
  -- disable when a .luarc.json file is found
  ---@type boolean|(fun(root:string):boolean?)
  enabled = function(root_dir)
    return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
  end,
  debug = false,
}

return opts
