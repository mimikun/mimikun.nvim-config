---@type LazySpec
local spec = {
  "brenton-leighton/multiple-cursors.nvim",
  --lazy = false,
  -- Use the latest tagged version
  version = "*",
  --ft = require("plugins.multiple-cursors-nvim.ft"),
  --cmd = require("plugins.multiple-cursors-nvim.cmds"),
  --keys = require("plugins.multiple-cursors-nvim.keys"),
  --event = require("plugins.multiple-cursors-nvim.events"),
  --dependencies = require("plugins.multiple-cursors-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  opts = require("plugins.multiple-cursors-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.multiple-cursors-nvim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
