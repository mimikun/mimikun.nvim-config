---@type LazySpec
local spec = {
  "dlyongemallo/diffview.nvim",
  --lazy = false,
  version = "*",
  cmd = require("plugins.diffview-nvim.cmds"),
  --keys = require("plugins.diffview-nvim.keys"),
  event = require("plugins.diffview-nvim.events"),
  dependencies = require("plugins.diffview-nvim.dependencies"),
  --opts = require("plugins.diffview-nvim.opts"),
  config = function()
    local opts = require("plugins.diffview-nvim.opts")
    require("diffview").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
