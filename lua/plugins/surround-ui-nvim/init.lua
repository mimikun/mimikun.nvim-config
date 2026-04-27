---@type LazySpec
local spec = {
  "roobert/surround-ui.nvim",
  --lazy = false,
  event = require("plugins.surround-ui-nvim.events"),
  dependencies = require("plugins.surround-ui-nvim.dependencies"),
  opts = require("plugins.surround-ui-nvim.opts"),
  --config = function()
  --local opts = require("plugins.surround-ui-nvim.opts")
  --require("surround-ui").setup(opts)
  --end,
  --cond = false,
  --enabled = false,
}

return spec
