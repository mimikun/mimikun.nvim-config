---@type LazySpec
local spec = {
  "VonHeikemen/searchbox.nvim",
  --lazy = false,
  --ft = require("plugins.searchbox-nvim.ft"),
  --cmd = require("plugins.searchbox-nvim.cmds"),
  --keys = require("plugins.searchbox-nvim.keys"),
  event = require("plugins.searchbox-nvim.events"),
  dependencies = require("plugins.searchbox-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.searchbox-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.searchbox-nvim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
