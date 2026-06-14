---@type LazySpec
local spec = {
  "FylerOrg/fyler.nvim",
  --lazy = false,
  cmd = require("plugins.fyler-nvim.cmds"),
  keys = require("plugins.fyler-nvim.keys"),
  event = require("plugins.fyler-nvim.events"),
  dependencies = require("plugins.fyler-nvim.dependencies"),
  --opts = require("plugins.fyler-nvim.opts"),
  config = function()
    local opts = require("plugins.fyler-nvim.opts")
    require("fyler").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
