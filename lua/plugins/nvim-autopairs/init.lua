---@type LazySpec
local spec = {
  "windwp/nvim-autopairs",
  --lazy = false,
  --ft = require("plugins.nvim-autopairs.ft"),
  --cmd = require("plugins.nvim-autopairs.cmds"),
  --keys = require("plugins.nvim-autopairs.keys"),
  event = require("plugins.nvim-autopairs.events"),
  --dependencies = require("plugins.nvim-autopairs.dependencies"),
  opts = require("plugins.nvim-autopairs.opts"),
  --config = function()
  --require("nvim-autopairs").setup({})
  --end,
  --cond = false,
  --enabled = false,
}

return spec
