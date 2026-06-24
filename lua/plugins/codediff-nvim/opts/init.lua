---@type table
local opts = {
  -- Highlight configuration
  highlights = require("plugins.codediff-nvim.opts.highlights"),

  -- Diff view behavior
  diff = require("plugins.codediff-nvim.opts.diff"),

  -- Explorer panel configuration
  explorer = require("plugins.codediff-nvim.opts.explorer"),

  -- History panel configuration (for :CodeDiff history)
  history = require("plugins.codediff-nvim.opts.history"),

  -- Keymaps
  keymaps = require("plugins.codediff-nvim.opts.keymaps"),
}

return opts
