---@type LazySpec
local spec = {
  "romgrk/barbar.nvim",
  -- optional: only update when a new 1.x version is released
  --version = '^1.0.0',
  lazy = false,
  --ft = require("plugins.barbar-nvim.ft"),
  --ft = { "lua" },
  cmd = require("plugins.barbar-nvim.cmds"),
  --keys = require("plugins.barbar-nvim.keys"),
  --event = require("plugins.barbar-nvim.events"),
  --event = "VeryLazy",
  dependencies = require("plugins.barbar-nvim.dependencies"),
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = require("plugins.barbar-nvim.opts"),
  --config = function()
  --    INIT
  --end,
  --cond = false,
  --enabled = false,
}

return spec
