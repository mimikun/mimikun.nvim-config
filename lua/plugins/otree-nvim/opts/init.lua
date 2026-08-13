---@type table
local opts = {
  win_size = 30,
  open_on_startup = false,
  use_default_keymaps = true,
  hijack_netrw = true,
  show_hidden = false,
  show_ignore = false,
  cursorline = true,
  focus_on_enter = false,
  open_on_left = true,
  git_signs = false,
  lsp_signs = false,
  oil = "float",

  ignore_patterns = require("plugins.otree-nvim.opts.ignore_patterns"),

  keymaps = require("plugins.otree-nvim.opts.keymaps"),

  tree = require("plugins.otree-nvim.opts.tree"),

  icons = require("plugins.otree-nvim.opts.icons"),

  highlights = require("plugins.otree-nvim.opts.highlights"),

  float = require("plugins.otree-nvim.opts.float"),
}

return opts
