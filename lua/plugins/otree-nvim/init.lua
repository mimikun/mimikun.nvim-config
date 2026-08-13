---@type LazySpec
local spec = {
  "Eutrius/Otree.nvim",
  lazy = false,
  cmd = require("plugins.otree-nvim.cmds"),
  event = require("plugins.otree-nvim.events"),
  dependencies = require("plugins.otree-nvim.dependencies"),
  --opts = require("plugins.otree-nvim.opts"),
  config = function()
    local opts = require("plugins.otree-nvim.opts")
    require("Otree").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
