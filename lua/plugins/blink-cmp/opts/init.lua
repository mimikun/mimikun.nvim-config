---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
  ---@type blink.cmp.KeymapConfig
  keymap = require("plugins.blink-cmp.opts.keymap"),

  ---@type blink.cmp.AppearanceConfig
  appearance = require("plugins.blink-cmp.opts.appearance"),

  ---@type blink.cmp.CompletionConfig
  completion = require("plugins.blink-cmp.opts.completion"),

  ---@type blink.cmp.SourceConfig
  sources = require("plugins.blink-cmp.opts.sources"),

  ---@type blink.cmp.SnippetsConfig
  snippets = require("plugins.blink-cmp.opts.snippets"),

  ---@type blink.cmp.FuzzyConfig
  fuzzy = require("plugins.blink-cmp.opts.fuzzy"),

  ---@type blink.cmp.CmdlineConfig
  cmdline = require("plugins.blink-cmp.opts.cmdline"),
}

return opts
