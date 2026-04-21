---@type LazySpec
local spec = {
  "ZWindL/orphans.nvim",
  --lazy = false,
  cmd = require("plugins.orphans-nvim.cmds"),
  event = require("plugins.orphans-nvim.events"),
  opts = require("plugins.orphans-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
