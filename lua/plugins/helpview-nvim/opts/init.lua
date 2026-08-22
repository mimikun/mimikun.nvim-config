---@type helpview.config
local opts = {
  -- Custom renderers
  ---@type { [string]: function }
  renderers = require("plugins.helpview-nvim.opts.renderers"),

  -- Preview options
  ---@type helpview.preview
  preview = require("plugins.helpview-nvim.opts.preview"),

  -- Configuration options for vimdoc
  ---@type helpview.vimdoc
  vimdoc = require("plugins.helpview-nvim.opts.vimdoc"),

  -- Custom highlight groups
  ---@type table[]
  --highlight_groups = require("plugins.helpview-nvim.opts.highlight_groups"),
}

return opts
