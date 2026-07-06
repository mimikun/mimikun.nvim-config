---@type LazySpec
local spec = {
  "ergodice/statuscol-oil.nvim",
  --lazy = false,
  dependencies = require("plugins.statuscol-oil-nvim.dependencies"),
  --opts = require("plugins.statuscol-oil-nvim.opts"),
  config = function()
    local opts = require("plugins.statuscol-oil-nvim.opts")
    require("statuscol-oil").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
