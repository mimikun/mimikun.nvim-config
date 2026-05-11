---@type LazySpec
local spec = {
  "SmiteshP/nvim-navic",
  --lazy = false,
  event = require("plugins.nvim-navic.events"),
  dependencies = require("plugins.nvim-navic.dependencies"),
  opts = require("plugins.nvim-navic.opts"),
  --config = function()
  --local opts = require("plugins.nvim-navic.opts")
  --require("nvim-navic").setup(opts)
  --end,
  --cond = false,
  --enabled = false,
}

return spec
