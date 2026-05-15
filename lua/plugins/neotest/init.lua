---@type LazySpec
local spec = {
  "nvim-neotest/neotest",
  --lazy = false,
  --ft = require("plugins.neotest.ft"),
  --cmd = require("plugins.neotest.cmds"),
  --keys = require("plugins.neotest.keys"),
  --event = require("plugins.neotest.events"),
  dependencies = require("plugins.neotest.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.neotest.opts"),
  --config = function()
  --  local opts = require("plugins.neotest.opts")
  --end,
  --cond = false,
  --enabled = false,
}

return spec
