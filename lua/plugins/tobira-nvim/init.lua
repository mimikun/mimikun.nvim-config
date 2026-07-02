---@type LazySpec
local spec = {
  "kamegoro/tobira.nvim",
  --lazy = false,
  cmd = require("plugins.tobira-nvim.cmds"),
  event = require("plugins.tobira-nvim.events"),
  dependencies = require("plugins.tobira-nvim.dependencies"),
  --opts = require("plugins.tobira-nvim.opts"),
  config = function()
    local opts = require("plugins.tobira-nvim.opts")
    require("tobira").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
