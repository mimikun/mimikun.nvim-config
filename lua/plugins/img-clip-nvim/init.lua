---@type LazySpec
local spec = {
  "HakonHarnes/img-clip.nvim",
  --lazy = false,
  ft = require("plugins.img-clip-nvim.ft"),
  cmd = require("plugins.img-clip-nvim.cmds"),
  keys = require("plugins.img-clip-nvim.keys"),
  event = require("plugins.img-clip-nvim.events"),
  opts = require("plugins.img-clip-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
