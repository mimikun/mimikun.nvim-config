---@type table
local opts = {
  -- Path-based loading
  paths = require("plugins.homeassistant-nvim.opts.paths"),

  -- LSP Server settings
  lsp = require("plugins.homeassistant-nvim.opts.lsp"),

  -- UI settings
  ui = require("plugins.homeassistant-nvim.opts.ui"),

  -- Logging
  logging = require("plugins.homeassistant-nvim.opts.logging"),

  -- Custom keymaps (set to false to disable defaults)
  keymaps = require("plugins.homeassistant-nvim.opts.keymaps"),
}

return opts
