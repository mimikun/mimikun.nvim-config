---@type LazySpec
local spec = {
  "iwe-org/iwe.nvim",
  --lazy = false,
  cmd = require("plugins.iwe-nvim.cmds"),
  event = require("plugins.iwe-nvim.events"),
  dependencies = require("plugins.iwe-nvim.dependencies"),
  --opts = require("plugins.iwe-nvim.opts"),
  config = function()
    local opts = require("plugins.iwe-nvim.opts")
    require("iwe").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
