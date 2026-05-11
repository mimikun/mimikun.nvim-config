---@type LazySpec
local spec = {
  "nvimdev/lspsaga.nvim",
  --lazy = false,
  --ft = require("plugins.lspsaga-nvim.ft"),
  cmd = require("plugins.lspsaga-nvim.cmds"),
  --keys = require("plugins.lspsaga-nvim.keys"),
  event = require("plugins.lspsaga-nvim.events"),
  dependencies = require("plugins.lspsaga-nvim.dependencies"),
  --opts = require("plugins.lspsaga-nvim.opts"),
  config = function()
    local opts = require("plugins.lspsaga-nvim.opts")
    require("lspsaga").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
