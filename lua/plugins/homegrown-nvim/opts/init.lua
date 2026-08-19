---@type table
local opts = {
  -- Pass a boolean to enable a module with default options

  -- Enable ColorHighlighterToggle command
  highlighter = require("plugins.homegrown-nvim.opts.highlighter"),

  -- Enable clipboard copy utilities (including CopyGitUrl)
  copy = require("plugins.homegrown-nvim.opts.copy"),

  -- Enable MDPreview command
  md_preview = require("plugins.homegrown-nvim.opts.md_preview"),

  -- Enable zero-dependency autopairs
  pairs = require("plugins.homegrown-nvim.opts.pairs"),

  -- Enable project search & replace
  replace = require("plugins.homegrown-nvim.opts.replace"),

  -- Enable async code runner command
  runner = require("plugins.homegrown-nvim.opts.runner"),

  -- Enable Snacks-based terminal commands (needs snacks.nvim)
  terminal = require("plugins.homegrown-nvim.opts.terminal"),

  -- Enable seamless vim/tmux navigation
  tmux = require("plugins.homegrown-nvim.opts.tmux"),

  -- Enable RootDir, RangerPicker, and background Git commands
  dir = require("plugins.homegrown-nvim.opts.dir"),

  -- Or pass a table to customize specific configuration options
  bracket_nav = require("plugins.homegrown-nvim.opts.bracket_nav"),

  tiling = require("plugins.homegrown-nvim.opts.tiling"),
}

return opts
