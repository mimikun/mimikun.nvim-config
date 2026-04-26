---@type LazySpec
local spec = {
  "stevearc/overseer.nvim",
  --lazy = false,
  cmd = require("plugins.overseer-nvim.cmds"),
  --keys = require("plugins.overseer-nvim.keys"),
  event = require("plugins.overseer-nvim.events"),
  --dependencies = require("plugins.overseer-nvim.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("plugins.overseer-nvim.opts"),
  config = function()
    local opts = require("plugins.overseer-nvim.opts")
    require("overseer").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
