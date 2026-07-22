---@type LazySpec
local spec = {
  "folke/which-key.nvim",
  --lazy = false,
  cmd = require("plugins.which-key-nvim.cmds"),
  keys = require("plugins.which-key-nvim.keys"),
  event = require("plugins.which-key-nvim.events"),
  dependencies = require("plugins.which-key-nvim.dependencies"),
  --opts = require("plugins.which-key-nvim.opts"),
  config = function()
    local opts = require("plugins.which-key-nvim.opts")
    require("which-key").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
