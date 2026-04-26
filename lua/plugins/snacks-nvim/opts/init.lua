---@type snacks.Config
local opts = {
  ---@type snacks.bigfile.Config
  bigfile = require("plugins.snacks-nvim.opts.bigfile"),
  ---@type snacks.dashboard.Config
  dashboard = require("plugins.snacks-nvim.opts.dashboard"),
  ---@type snacks.dim.Config
  dim = require("plugins.snacks-nvim.opts.dim"),
  ---@type snacks.explorer.Config
  explorer = require("plugins.snacks-nvim.opts.explorer"),
  ---@type snacks.gh.Config
  gh = require("plugins.snacks-nvim.opts.gh"),
  ---@type snacks.gitbrowse.Config
  gitbrowse = require("plugins.snacks-nvim.opts.gitbrowse"),
  ---@type snacks.indent.Config
  indent = require("plugins.snacks-nvim.opts.indent"),
  ---@type snacks.input.Config
  input = require("plugins.snacks-nvim.opts.input"),
  ---@type snacks.lazygit.Config
  lazygit = require("plugins.snacks-nvim.opts.lazygit"),
  ---@type snacks.notifier.Config
  notifier = require("plugins.snacks-nvim.opts.notifier"),
  ---@type snacks.picker.Config
  picker = require("plugins.snacks-nvim.opts.picker"),
  ---@type snacks.profiler.Config
  profiler = require("plugins.snacks-nvim.opts.profiler"),
  ---@type snacks.quickfile.Config
  quickfile = require("plugins.snacks-nvim.opts.quickfile"),
  ---@type snacks.scope.Config
  scope = require("plugins.snacks-nvim.opts.scope"),
  ---@type snacks.scratch.Config
  scratch = require("plugins.snacks-nvim.opts.scratch"),
  ---@type snacks.scroll.Config
  scroll = require("plugins.snacks-nvim.opts.scroll"),
  ---@type snacks.statuscolumn.Config
  statuscolumn = require("plugins.snacks-nvim.opts.statuscolumn"),
  ---@type snacks.terminal.Config
  terminal = require("plugins.snacks-nvim.opts.terminal"),
  ---@type snacks.toggle.Config
  toggle = require("plugins.snacks-nvim.opts.toggle"),
  ---@type snacks.win.Config
  win = require("plugins.snacks-nvim.opts.win"),
  ---@type snacks.words.Config
  words = require("plugins.snacks-nvim.opts.words"),
  ---@type snacks.zen.Config
  zen = require("plugins.snacks-nvim.opts.zen"),
  ---@type snacks.image.Config
  image = require("plugins.snacks-nvim.opts.image"),
}

return opts
