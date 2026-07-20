---@type LazySpec
local spec = {
  "mrjones2014/codesettings.nvim",
  -- You don't need to lazy load this plugin since it already
  -- lazy loads its constituent parts via `plugin/*` and `ftplugin/*` files
  lazy = false,
  --ft = require("plugins.codesettings-nvim.ft"),
  cmd = require("plugins.codesettings-nvim.cmds"),
  --keys = require("plugins.codesettings-nvim.keys"),
  --event = require("plugins.codesettings-nvim.events"),
  --dependencies = require("plugins.codesettings-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.codesettings-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.codesettings-nvim.opts")
  --end,
  --priority = 1000,
  cond = false,
  enabled = false,
}

return spec
