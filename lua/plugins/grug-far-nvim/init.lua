---@type LazySpec
local spec = {
  "MagicDuck/grug-far.nvim",
  --lazy = false,
  --ft = require("plugins.grug-far-nvim.ft"),
  --cmd = require("plugins.grug-far-nvim.cmds"),
  --keys = require("plugins.grug-far-nvim.keys"),
  --event = require("plugins.grug-far-nvim.events"),
  dependencies = require("plugins.grug-far-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.grug-far-nvim.opts"),
  config = function()
    local opts = require("plugins.grug-far-nvim.opts")
    --vim.g.grug_far = opts
    --require('grug-far').setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
