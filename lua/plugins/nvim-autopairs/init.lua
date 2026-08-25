---@type LazySpec
local spec = {
  "windwp/nvim-autopairs",
  --lazy = false,
  event = require("plugins.nvim-autopairs.events"),
  --opts = require("plugins.nvim-autopairs.opts"),
  config = function()
    local opts = require("plugins.nvim-autopairs.opts")
    local npairs = require("nvim-autopairs")

    npairs.setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
