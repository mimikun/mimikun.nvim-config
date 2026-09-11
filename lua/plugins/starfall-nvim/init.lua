---@type LazySpec
local spec = {
  "RedEye-Developers/starfall.nvim",
  --lazy = false,
  cmd = require("plugins.starfall-nvim.cmds"),
  keys = require("plugins.starfall-nvim.keys"),
  event = require("plugins.starfall-nvim.events"),
  --opts = require("plugins.starfall-nvim.opts"),
  config = function()
    local opts = require("plugins.starfall-nvim.opts")
    require("starfall").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
