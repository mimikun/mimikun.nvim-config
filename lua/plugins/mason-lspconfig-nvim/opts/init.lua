---@type table
local opts = {
  -- A list of servers to automatically install if they're not already installed.
  ---@type string[]
  ensure_installed = require("plugins.mason-lspconfig-nvim.opts.ensure_installed"),
  -- To exclude certain servers from being automatically enabled:
  ---@type boolean | string[] | { exclude: string[] }
  automatic_enable = require("plugins.mason-lspconfig-nvim.opts.automatic_enable"),
}

return opts
