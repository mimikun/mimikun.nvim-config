---@type LazySpec
local spec = {
  "jeangiraldoo/codedocs.nvim",
  --lazy = false,
  cmd = require("plugins.codedocs-nvim.cmds"),
  keys = require("plugins.codedocs-nvim.keys"),
  event = require("plugins.codedocs-nvim.events"),
  dependencies = require("plugins.codedocs-nvim.dependencies"),
  --opts = require("plugins.codedocs-nvim.opts"),
  config = function()
    local opts = require("plugins.codedocs-nvim.opts")
    require("codedocs").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
