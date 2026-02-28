---@type LazySpec
local spec = {
  "sphamba/smear-cursor.nvim",
  --lazy = false,
  cmd = require("plugins.smear-cursor-nvim.cmds"),
  event = require("plugins.smear-cursor-nvim.events"),
  opts = require("plugins.smear-cursor-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
