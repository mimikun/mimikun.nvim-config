---@type LazySpec
local spec = {
  "epwalsh/pomo.nvim",
  --lazy = false,
  -- Recommended, use latest release instead of latest commit
  --version = "*",
  cmd = require("plugins.pomo-nvim.cmds"),
  event = require("plugins.pomo-nvim.events"),
  dependencies = require("plugins.pomo-nvim.dependencies"),
  opts = require("plugins.pomo-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
