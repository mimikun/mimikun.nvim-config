---@type MultipleCursor.Config
local opts = {
  ---@type MultipleCursor.Keymaps
  keymaps = require("plugins.multiple-cursor-nvim.opts.keymaps"),

  ---@type MultipleCursor.Highlights
  highlights = require("plugins.multiple-cursor-nvim.opts.highlights"),

  ---@type MultipleCursor.HighlightDefinitions
  highlight_definitions = require("plugins.multiple-cursor-nvim.opts.highlight_definitions"),

  -- Floating overlay window for selection count (easier to see)
  -- Overlay window configuration
  ---@type MultipleCursor.OverlayConfig
  overlay = require("plugins.multiple-cursor-nvim.opts.overlay"),

  -- Only match whole words
  ---@type boolean
  match_whole_word = true,

  -- Case sensitive matching
  ---@type boolean
  case_sensitive = true,
}

return opts
