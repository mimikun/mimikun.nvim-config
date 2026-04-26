---@type LazySpec
local spec = {
  "stevearc/aerial.nvim",
  --lazy = false,
  cmd = require("plugins.aerial-nvim.cmds"),
  keys = require("plugins.aerial-nvim.keys"),
  event = require("plugins.aerial-nvim.events"),
  dependencies = require("plugins.aerial-nvim.dependencies"),
  --opts = require("plugins.aerial-nvim.opts"),
  config = function()
    local opts = require("plugins.aerial-nvim.opts")
    require("aerial").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
