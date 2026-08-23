---@type table
local opts = {
  ui = require("plugins.lspsaga-nvim.opts.ui"),
  hover = require("plugins.lspsaga-nvim.opts.hover"),
  diagnostic = require("plugins.lspsaga-nvim.opts.diagnostic"),
  code_action = require("plugins.lspsaga-nvim.opts.code_action"),
  lightbulb = require("plugins.lspsaga-nvim.opts.lightbulb"),
  scroll_preview = require("plugins.lspsaga-nvim.opts.scroll_preview"),
  request_timeout = 2000,
  finder = require("plugins.lspsaga-nvim.opts.finder"),
  definition = require("plugins.lspsaga-nvim.opts.definition"),
  rename = require("plugins.lspsaga-nvim.opts.rename"),
  symbol_in_winbar = require("plugins.lspsaga-nvim.opts.symbol_in_winbar"),
  outline = require("plugins.lspsaga-nvim.opts.outline"),
  callhierarchy = require("plugins.lspsaga-nvim.opts.callhierarchy"),
  typehierarchy = require("plugins.lspsaga-nvim.opts.typehierarchy"),
  implement = require("plugins.lspsaga-nvim.opts.implement"),
  beacon = require("plugins.lspsaga-nvim.opts.beacon"),
  floaterm = require("plugins.lspsaga-nvim.opts.floaterm"),
}

return opts
