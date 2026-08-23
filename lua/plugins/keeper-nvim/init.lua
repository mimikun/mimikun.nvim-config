---@type LazySpec
local spec = {
  "n3tw0rth/keeper.nvim",
  --lazy = false,
  cmd = require("plugins.keeper-nvim.cmds"),
  keys = require("plugins.keeper-nvim.keys"),
  event = require("plugins.keeper-nvim.events"),
  --opts = require("plugins.keeper-nvim.opts"),
  config = function()
    local opts = require("plugins.keeper-nvim.opts")
    require("keeper").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
