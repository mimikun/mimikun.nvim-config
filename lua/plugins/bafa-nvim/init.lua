---@type LazySpec
local spec = {
  "mistweaverco/bafa.nvim",
  --lazy = false,
  --version = "v1.12.3",
  event = require("plugins.bafa-nvim.events"),
  --opts = require("plugins.bafa-nvim.opts"),
  config = function()
    local opts = require("plugins.bafa-nvim.opts")
    require("bafa").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
