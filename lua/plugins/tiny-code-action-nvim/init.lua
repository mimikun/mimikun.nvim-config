---@type LazySpec
local spec = {
  "rachartier/tiny-code-action.nvim",
  --lazy = false,
  keys = require("plugins.tiny-code-action-nvim.keys"),
  event = require("plugins.tiny-code-action-nvim.events"),
  dependencies = require("plugins.tiny-code-action-nvim.dependencies"),
  --opts = require("plugins.tiny-code-action-nvim.opts"),
  config = function()
    local opts = require("plugins.tiny-code-action-nvim.opts")
    require("tiny-code-action").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
