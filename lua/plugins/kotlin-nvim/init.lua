---@type LazySpec
local spec = {
  "AlexandrosAlexiou/kotlin.nvim",
  --lazy = false,
  ft = require("plugins.kotlin-nvim.ft"),
  --cmd = require("plugins.kotlin-nvim.cmds"),
  --keys = require("plugins.kotlin-nvim.keys"),
  --event = require("plugins.kotlin-nvim.events"),
  dependencies = require("plugins.kotlin-nvim.dependencies"),
  --opts = require("plugins.kotlin-nvim.opts"),
  config = function()
  local opts = require("plugins.kotlin-nvim.opts")
        require("kotlin").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
