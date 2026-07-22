---@type LazySpec
local spec = {
  "folke/zen-mode.nvim",
  --lazy = false,
  cmd = require("plugins.zen-mode-nvim.cmds"),
  event = require("plugins.zen-mode-nvim.events"),
  dependencies = require("plugins.zen-mode-nvim.dependencies"),
  --opts = require("plugins.zen-mode-nvim.opts"),
  config = function()
    local opts = require("plugins.zen-mode-nvim.opts")
    require("zen-mode").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
