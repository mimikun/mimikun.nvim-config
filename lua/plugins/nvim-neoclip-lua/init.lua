---@type LazySpec
local spec = {
  "AckslD/nvim-neoclip.lua",
  --lazy = false,
  event = require("plugins.nvim-neoclip-lua.events"),
  dependencies = require("plugins.nvim-neoclip-lua.dependencies"),
  opts = require("plugins.nvim-neoclip-lua.opts"),
  --config = function()
  --local opts = require("plugins.nvim-neoclip-lua.opts")
  --require("neoclip").setup(opts)
  --end,
  --cond = false,
  --enabled = false,
}

return spec
