---@type LazySpec
local spec = {
  "necrom4/calcium.nvim",
  --lazy = false,
  cmd = require("plugins.calcium-nvim.cmds"),
  keys = require("plugins.calcium-nvim.keys"),
  event = require("plugins.calcium-nvim.events"),
  --opts = require("plugins.calcium-nvim.opts"),
  config = function()
    local opts = require("plugins.calcium-nvim.opts")
    require("calcium").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
