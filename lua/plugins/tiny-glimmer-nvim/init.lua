---@type LazySpec
local spec = {
  "rachartier/tiny-glimmer.nvim",
  --lazy = false,
  cmd = require("plugins.tiny-glimmer-nvim.cmds"),
  keys = require("plugins.tiny-glimmer-nvim.keys"),
  event = require("plugins.tiny-glimmer-nvim.events"),
  dependencies = require("plugins.tiny-glimmer-nvim.dependencies"),
  --opts = require("plugins.tiny-glimmer-nvim.opts"),
  config = function()
    local opts = require("plugins.tiny-glimmer-nvim.opts")
    require("tiny-glimmer").setup(opts)
  end,
  priority = 10,
  --cond = false,
  --enabled = false,
}

return spec
