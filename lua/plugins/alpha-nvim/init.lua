---@type LazySpec
local spec = {
  "goolord/alpha-nvim",
  --lazy = false,
  cmd = require("plugins.alpha-nvim.cmds"),
  event = require("plugins.alpha-nvim.events"),
  dependencies = require("plugins.alpha-nvim.dependencies"),
  --opts = require("plugins.alpha-nvim.opts"),
  config = function()
    local opts = require("plugins.alpha-nvim.opts")
    require("alpha").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
