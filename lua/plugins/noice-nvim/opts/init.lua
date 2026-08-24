---@type NoiceConfig
local opts = {
  cmdline = require("plugins.noice-nvim.opts.cmdline"),
  messages = require("plugins.noice-nvim.opts.messages"),
  popupmenu = require("plugins.noice-nvim.opts.popupmenu"),
  redirect = require("plugins.noice-nvim.opts.redirect"),
  commands = require("plugins.noice-nvim.opts.commands"),
  notify = require("plugins.noice-nvim.opts.notify"),
  lsp = require("plugins.noice-nvim.opts.lsp"),
  markdown = require("plugins.noice-nvim.opts.markdown"),
  health = {
    -- Disable if you don't want health checks to run
    checker = true,
  },
  presets = require("plugins.noice-nvim.opts.presets"),

  -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
  throttle = 1000 / 30,

  ---@type NoiceConfigViews
  views = require("plugins.noice-nvim.opts.views"),

  ---@type NoiceRouteConfig[]
  routes = {},

  ---@type table<string, NoiceFilter>
  status = {},

  ---@type NoiceFormatOptions
  format = {},

  debug = false,
  log = vim.fn.stdpath("state") .. "/noice.log",

  -- 10MB
  log_max_size = 1024 * 1024 * 2,
}

return opts
