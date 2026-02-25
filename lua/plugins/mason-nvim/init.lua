---@type LazySpec
local spec = {
  "mason-org/mason.nvim",
  --lazy = false,
  cmd = require("plugins.mason-nvim.cmds"),
  event = require("plugins.mason-nvim.events"),
  --opts = require("plugins.mason-nvim.opts"),
  config = function()
    require("mason").setup(require("plugins.mason-nvim.opts"))
  end,
  --cond = false,
  --enabled = false,
}

return spec
