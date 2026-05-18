---@type LazySpec
local spec = {
    "nvim-neo-tree/neo-tree.nvim",
        -- neo-tree will lazily load itself
  lazy = false,
    branch = "v3.x",
  --ft = require("plugins.neo-tree-nvim.ft"),
  cmd = require("plugins.neo-tree-nvim.cmds"),
  --keys = require("plugins.neo-tree-nvim.keys"),
  --event = require("plugins.neo-tree-nvim.events"),
  dependencies = require("plugins.neo-tree-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.neo-tree-nvim.opts"),
  config = function()
    local opts = require("plugins.neo-tree-nvim.opts")
require('neo-tree').setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
