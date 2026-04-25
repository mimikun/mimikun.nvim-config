---@type LazySpec
local spec = {
  "serhez/bento.nvim",
  --lazy = false,
  cmd = require("plugins.bento-nvim.cmds"),
  event = require("plugins.bento-nvim.events"),
  opts = require("plugins.bento-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
