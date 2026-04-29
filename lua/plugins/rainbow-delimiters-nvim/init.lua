---@type LazySpec
local spec = {
  --"HiPhish/rainbow-delimiters.nvim",
  url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  --lazy = false,
  event = require("plugins.rainbow-delimiters-nvim.events"),
  --opts = require("plugins.rainbow-delimiters-nvim.opts"),
  config = function()
    local opts = require("plugins.rainbow-delimiters-nvim.opts")
    vim.g.rainbow_delimiters = opts
    --require('rainbow-delimiters.setup').setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
