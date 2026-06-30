---@type LazySpec
local spec = {
  "ThePrimeagen/refactoring.nvim",
  lazy = false,
  --ft = require("plugins.refactoring-nvim.ft"),
  cmd = require("plugins.refactoring-nvim.cmds"),
  --keys = require("plugins.refactoring-nvim.keys"),
  event = require("plugins.refactoring-nvim.events"),
  dependencies = require("plugins.refactoring-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.refactoring-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.refactoring-nvim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
