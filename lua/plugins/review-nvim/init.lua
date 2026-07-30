---@type LazySpec
local spec = {
  "vuki656/review.nvim",
  --lazy = false,
  cmd = require("plugins.review-nvim.cmds"),
  keys = require("plugins.review-nvim.keys"),
  event = require("plugins.review-nvim.events"),
  dependencies = require("plugins.review-nvim.dependencies"),
  --opts = require("plugins.review-nvim.opts"),
  config = function()
    local opts = require("plugins.review-nvim.opts")
    require("review").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
