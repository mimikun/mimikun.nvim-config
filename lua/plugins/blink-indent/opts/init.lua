---@module 'blink.indent'
---@type blink.indent.Config
local opts = {
  -- filetypes where scopes are closed by dedenting, such as python and yaml set to true to treat all filetypes this way
  ---@type blink.indent.DedentScopedFiletypes
  dedent_scoped_filetypes = {
    include_defaults = true,
  },

  ---@type blink.indent.BlockedConfig
  blocked = require("plugins.blink-indent.opts.blocked"),

  ---@type blink.indent.MappingsConfig
  mappings = require("plugins.blink-indent.opts.mappings"),

  ---@type blink.indent.StaticConfig
  static = require("plugins.blink-indent.opts.static"),

  ---@type blink.indent.ScopeConfig
  scope = require("plugins.blink-indent.opts.scope"),
}

return opts
