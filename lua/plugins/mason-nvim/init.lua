---@type LazySpec
local spec = {
  "mason-org/mason.nvim",
  --lazy = false,
  cmd = require("plugins.mason-nvim.cmds"),
  event = require("plugins.mason-nvim.events"),
  --opts = require("plugins.mason-nvim.opts"),
  config = function()
    local opts = require("plugins.mason-nvim.opts")
    require("mason").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
