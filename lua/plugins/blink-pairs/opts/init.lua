---@module 'blink.pairs'
---@type blink.pairs.Config
local opts = {
  ---@type blink.pairs.MappingsConfig
  mappings = require("plugins.blink-pairs.opts.mappings"),
  ---@type blink.pairs.HighlightsConfig
  highlights = require("plugins.blink-pairs.opts.highlights"),
  ---@type boolean
  debug = false,
}

return opts
