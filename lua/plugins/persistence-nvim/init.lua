---@type LazySpec
local spec = {
  "folke/persistence.nvim",
  --lazy = false,
  keys = require("plugins.persistence-nvim.keys"),
  event = require("plugins.persistence-nvim.events"),
  --opts = require("plugins.persistence-nvim.opts"),
  config = function()
    local opts = require("plugins.persistence-nvim.opts")
    require("persistence").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
