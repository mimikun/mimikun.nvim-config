---@type LazySpec
local spec = {
  "nvim-tree/nvim-web-devicons",
  --lazy = false,
  cmd = require("plugins.nvim-web-devicons.cmds"),
  event = require("plugins.nvim-web-devicons.events"),
  --opts = require("plugins.nvim-web-devicons.opts"),
  --config = function()
  --local opts = require("plugins.nvim-web-devicons.opts")
  --require("nvim-web-devicons").setup(opts)
  --end,
  --cond = false,
  --enabled = false,
}

return spec
