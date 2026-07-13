---@type LazySpec
local spec = {
  "justinmk/guh.nvim",
  --lazy = false,
  cmd = require("plugins.guh-nvim.cmds"),
  event = require("plugins.guh-nvim.events"),
  dependencies = require("plugins.guh-nvim.dependencies"),
  --cond = false,
  --enabled = false,
}

return spec
