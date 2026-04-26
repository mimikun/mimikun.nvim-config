---@type LazySpec
local spec = {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  event = require("colorschemes.solarized-osaka-nvim.events"),
  --opts = require("colorschemes.solarized-osaka-nvim.opts"),
  config = function()
    local opts = require("colorschemes.solarized-osaka-nvim.opts")
    require("solarized-osaka").setup(opts)
  end,
  priority = 1000,
  cond = false,
  enabled = false,
}

return spec
