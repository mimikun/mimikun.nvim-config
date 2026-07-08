---@type LazySpec
local spec = {
  "willothy/ports.nvim",
  --lazy = false,
  cmd = require("plugins.ports-nvim.cmds"),
  keys = require("plugins.ports-nvim.keys"),
  event = require("plugins.ports-nvim.events"),
  --opts = require("plugins.ports-nvim.opts"),
  config = function()
    local opts = require("plugins.ports-nvim.opts")
    require("ports").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
