---@type LazySpec
local spec = {
  "lukas-reineke/virt-column.nvim",
  --lazy = false,
  event = require("plugins.virt-column-nvim.events"),
  opts = require("plugins.virt-column-nvim.opts"),
  --config = function()
  --local opts = require("plugins.virt-column-nvim.opts")
  --require("virt-column").setup(opts)
  --end,
  --cond = false,
  --enabled = false,
}

return spec
