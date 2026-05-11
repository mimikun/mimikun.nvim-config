---@type LspsagaConfig
local opts = {
  -- Global UI config
  ---@type LspsagaConfig.Ui
  ui = require("plugins.lspsaga-nvim.opts.ui"),

  -- Hover documentation
  ---@type LspsagaConfig.Hover
  hover = require("plugins.lspsaga-nvim.opts.hover"),

  -- LSP Diagnostic popup
  ---@type LspsagaConfig.Diagnostic
  diagnostic = require("plugins.lspsaga-nvim.opts.diagnostic"),

  -- LSP Code Action popup
  ---@type LspsagaConfig.CodeAction
  code_action = require("plugins.lspsaga-nvim.opts.code_action"),

  -- LSP Lightbulb indicator
  ---@type LspsagaConfig.Lightbulb
  lightbulb = require("plugins.lspsaga-nvim.opts.lightbulb"),

  -- Keys to scroll
  ---@type LspsagaConfig.Scroll.Keys
  scroll_preview = require("plugins.lspsaga-nvim.opts.scroll_preview"),

  -- LSP request timeout
  ---@type integer
  request_timeout = 2000,

  -- Token/reference finder
  ---@type LspsagaConfig.Finder
  finder = require("plugins.lspsaga-nvim.opts.finder"),

  -- Definition
  ---@type LspsagaConfig.Definition
  definition = require("plugins.lspsaga-nvim.opts.definition"),

  -- Rename
  ---@type LspsagaConfig.Rename
  rename = require("plugins.lspsaga-nvim.opts.rename"),

  -- Breadcrumbs
  ---@type LspsagaConfig.Crumbs
  symbol_in_winbar = require("plugins.lspsaga-nvim.opts.symbol_in_winbar"),

  -- Outline
  ---@type LspsagaConfig.Outline
  outline = require("plugins.lspsaga-nvim.opts.outline"),

  -- Call hierarchy
  ---@type LspsagaConfig.Hierarchy
  callhierarchy = require("plugins.lspsaga-nvim.opts.callhierarchy"),

  -- Type hierarchy
  ---@type LspsagaConfig.Hierarchy
  typehierarchy = require("plugins.lspsaga-nvim.opts.typehierarchy"),

  -- Implementation
  ---@type LspsagaConfig.Implement
  implement = require("plugins.lspsaga-nvim.opts.implement"),

  -- Beacon
  ---@type LspsagaConfig.Beacon
  beacon = require("plugins.lspsaga-nvim.opts.beacon"),

  -- Floating terminal
  ---@type LspsagaConfig.Term
  floaterm = require("plugins.lspsaga-nvim.opts.floaterm"),
}

return opts
