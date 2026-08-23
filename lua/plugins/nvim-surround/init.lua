---@type LazySpec
local spec = {
  "kylechui/nvim-surround",
  --lazy = false,
  -- Use for stability;
  -- omit to use `main` branch for the latest features
  --version = "^4.0.0",
  event = require("plugins.nvim-surround.events"),
  --opts = require("plugins.nvim-surround.opts"),
  config = function()
    local opts = require("plugins.nvim-surround.opts")
    require("nvim-surround").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
