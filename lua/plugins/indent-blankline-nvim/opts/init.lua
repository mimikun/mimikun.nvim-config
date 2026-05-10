-- Configuration table for indent-blankline
---@module "ibl"
---@type ibl.config
local opts = {
  -- Enables or disables indent-blankline
  ---@type boolean
  enabled = true,

  -- Sets the amount indent-blankline debounces refreshes in milliseconds
  ---@type number
  debounce = 200,

  -- Configures the viewport of where indentation guides are generated
  ---@type ibl.config.viewport_buffer
  viewport_buffer = require("plugins.indent-blankline-nvim.opts.viewport_buffer"),

  -- Configures the indentation
  ---@type ibl.config.indent
  indent = require("plugins.indent-blankline-nvim.opts.indent"),

  -- Configures the whitespace
  ---@type ibl.config.whitespace
  whitespace = require("plugins.indent-blankline-nvim.opts.whitespace"),

  -- Configures the scope
  ---@type ibl.config.scope
  scope = require("plugins.indent-blankline-nvim.opts.scope"),

  -- Configures what is excluded from indent-blankline
  ---@type ibl.config.exclude
  exclude = require("plugins.indent-blankline-nvim.opts.exclude"),
}

return opts
