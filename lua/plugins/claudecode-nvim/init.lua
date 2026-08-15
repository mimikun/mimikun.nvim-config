---@type LazySpec
local spec = {
  "coder/claudecode.nvim",
  --lazy = false,
  cmd = require("plugins.claudecode-nvim.cmds"),
  keys = require("plugins.claudecode-nvim.keys"),
  event = require("plugins.claudecode-nvim.events"),
  dependencies = require("plugins.claudecode-nvim.dependencies"),
  --opts = require("plugins.claudecode-nvim.opts"),
  config = function()
    local opts = require("plugins.claudecode-nvim.opts")
    require("claudecode").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
