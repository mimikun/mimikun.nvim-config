---@type LazySpec
local spec = {
  "mistweaverco/kikao.nvim",
  --lazy = false,
  --version = "v3.3.4",
  event = require("plugins.kikao-nvim.events"),
  --opts = require("plugins.kikao-nvim.opts"),
  config = function()
    local opts = require("plugins.kikao-nvim.opts")
    require("kikao").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
