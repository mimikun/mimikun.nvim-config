---@type LazySpec
local spec = {
  "zk-org/zk-nvim",
  name = "zk",
  --lazy = false,
  --ft = require("plugins.zk-nvim.ft"),
  cmd = require("plugins.zk-nvim.cmds"),
  --keys = require("plugins.zk-nvim.keys"),
  --event = require("plugins.zk-nvim.events"),
  --dependencies = require("plugins.zk-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.zk-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.zk-nvim.opts")
  --end,
  --cond = false,
  --enabled = false,
}

return spec
