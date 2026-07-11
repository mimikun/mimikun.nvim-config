---@type LazySpec
local spec = {
  "yal212/pomodoro.nvim",
  --lazy = false,
  cmd = require("plugins.pomodoro-nvim.cmds"),
  keys = require("plugins.pomodoro-nvim.keys"),
  event = require("plugins.pomodoro-nvim.events"),
  dependencies = require("plugins.pomodoro-nvim.dependencies"),
  --opts = require("plugins.pomodoro-nvim.opts"),
  config = function()
    local opts = require("plugins.pomodoro-nvim.opts")
    require("pomodoro").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
