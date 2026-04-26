---@type snacks.dashboard.Config
local dashboard = {
  enabled = true,
  width = 60,
  -- dashboard position. nil for center
  row = nil,
  -- dashboard position. nil for center
  col = nil,
  pane_gap = 4, -- empty columns between vertical panes
  autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
  -- These settings are used by some built-in sections
  preset = require("plugins.snacks-nvim.opts.dashboard.presets"),
  -- item field formatters
  ---@type table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
  formats = require("plugins.snacks-nvim.opts.dashboard.formats"),
  ---@type snacks.dashboard.Section
  sections = require("plugins.snacks-nvim.opts.dashboard.sections"),
}

return dashboard
