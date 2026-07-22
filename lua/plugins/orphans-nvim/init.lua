---@type LazySpec
local spec = {
  "ZWindL/orphans.nvim",
  --lazy = false,
  cmd = require("plugins.orphans-nvim.cmds"),
  event = require("plugins.orphans-nvim.events"),
  --opts = require("plugins.orphans-nvim.opts"),
  config = function()
    local opts = require("plugins.orphans-nvim.opts")
    require("orphans").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
