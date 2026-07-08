---@type LazySpec
local spec = {
  "ctchen222/openspec.nvim",
  --lazy = false,
  cmd = require("plugins.openspec-nvim.cmds"),
  --keys = require("plugins.openspec-nvim.keys"),
  event = require("plugins.openspec-nvim.events"),
  --opts = require("plugins.openspec-nvim.opts"),
  config = function()
    local opts = require("plugins.openspec-nvim.opts")
    require("openspec").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
