---@type LazySpec
local spec = {
  "xeind/vallow.nvim",
  --lazy = false,
  cmd = require("plugins.vallow-nvim.cmds"),
  keys = require("plugins.vallow-nvim.keys"),
  event = require("plugins.vallow-nvim.events"),
  dependencies = require("plugins.vallow-nvim.dependencies"),
  --opts = require("plugins.vallow-nvim.opts"),
  config = function()
    local opts = require("plugins.vallow-nvim.opts")
    require("vallow").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
