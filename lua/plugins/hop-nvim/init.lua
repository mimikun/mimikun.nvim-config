---@type LazySpec
local spec = {
  "wsdjeg/hop.nvim",
  --lazy = false,
  --version = "*",
  cmd = require("plugins.hop-nvim.cmds"),
  keys = require("plugins.hop-nvim.keys"),
  event = require("plugins.hop-nvim.events"),
  --opts = require("plugins.hop-nvim.opts"),
  config = function()
    local opts = require("plugins.hop-nvim.opts")
    require("hop").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
