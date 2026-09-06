---@module "encore"
---@type EncoreConfig
local opts = {
  engine = require("plugins.encore-nvim.opts.engine"),
  hud = require("plugins.encore-nvim.opts.hud"),
  history = require("plugins.encore-nvim.opts.history"),
  report = require("plugins.encore-nvim.opts.report"),
  ui = require("plugins.encore-nvim.opts.ui"),
  filters = require("plugins.encore-nvim.opts.filters"),
  keymaps = require("plugins.encore-nvim.opts.keymaps"),
}

return opts
