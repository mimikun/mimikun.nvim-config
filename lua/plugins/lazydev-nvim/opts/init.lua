---@type lazydev.Config
local opts = {
  runtime = vim.env.VIMRUNTIME,

  ---@type lazydev.Library.spec[]
  library = require("plugins.lazydev-nvim.opts.library"),

  integrations = require("plugins.lazydev-nvim.opts.integrations"),

  ---@type boolean | (fun(root:string):boolean?)
  enabled = function(root_dir)
    -- always enable unless `vim.g.lazydev_enabled = false`
    local lazydev_enabled = (vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled)

    -- disable when a .luarc.json file is found
    local no_luarc_json = (not vim.uv.fs_stat(root_dir .. "/.luarc.json"))

    return lazydev_enabled and no_luarc_json
  end,

  debug = false,
}

return opts
