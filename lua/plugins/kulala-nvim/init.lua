---@type LazySpec
local spec = {
  "mistweaverco/kulala.nvim",
  --lazy = false,
  ft = require("plugins.kulala-nvim.ft"),
  --cmd = require("plugins.kulala-nvim.cmds"),
  keys = require("plugins.kulala-nvim.keys"),
  event = require("plugins.kulala-nvim.events"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  opts = require("plugins.kulala-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.kulala-nvim.opts")
  --end,
  --cond = false,
  --enabled = false,
}

return spec
