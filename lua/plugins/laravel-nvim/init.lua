---@type LazySpec
local spec = {
  "adalessa/laravel.nvim",
  --lazy = false,
  ft = require("plugins.laravel-nvim.ft"),
  --cmd = require("plugins.laravel-nvim.cmds"),
  --keys = require("plugins.laravel-nvim.keys"),
  event = require("plugins.laravel-nvim.events"),
  dependencies = require("plugins.laravel-nvim.dependencies"),
  --opts = require("plugins.laravel-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.laravel-nvim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
