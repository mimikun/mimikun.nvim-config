---@type table
local opts = {
  -- A list of servers to automatically install if they're not already installed.
  ---@type string[]
  ensure_installed = require("plugins.mason-lspconfig-nvim.opts.ensure_installed"),
  -- An allowlist of servers to automatically enable. Servers installed by
  -- ensure_installed but absent from this list stay installed without attaching.
  ---@type boolean | string[] | { exclude: string[] }
  automatic_enable = require("plugins.mason-lspconfig-nvim.opts.automatic_enable"),
}

return opts
