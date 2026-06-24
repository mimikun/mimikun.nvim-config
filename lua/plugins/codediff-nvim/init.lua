---@type LazySpec
local spec = {
  "esmuellert/codediff.nvim",
  --lazy = false,
  cmd = require("plugins.codediff-nvim.cmds"),
  event = require("plugins.codediff-nvim.events"),
  opts = require("plugins.codediff-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.codediff-nvim.opts")
  --end,
  --cond = false,
  --enabled = false,
}

return spec
