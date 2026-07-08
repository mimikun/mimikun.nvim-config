---@type table
local opts = {
  commands = true,
  keymaps = true,
  mappings = require("plugins.openspec-nvim.opts.mappings"),
  openspec = require("plugins.openspec-nvim.opts.openspec"),
  tasks = require("plugins.openspec-nvim.opts.tasks"),
  ui = require("plugins.openspec-nvim.opts.ui"),
  health = require("plugins.openspec-nvim.opts.health"),
  implement = require("plugins.openspec-nvim.opts.implement"),
}

return opts
