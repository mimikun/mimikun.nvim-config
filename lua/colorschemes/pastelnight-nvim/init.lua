---@type LazySpec
local spec = {
  "pauchiner/pastelnight.nvim",
  lazy = false,
  event = require("colorschemes.pastelnight-nvim.events"),
  --opts = require("colorschemes.pastelnight-nvim.opts"),
  config = function()
    local opts = require("colorschemes.pastelnight-nvim.opts")
    require("pastelnight").setup(opts)
    --vim.cmd.colorscheme("pastelnight")
    --vim.cmd.colorscheme("pastelnight-high-contrast")
  end,
  priority = 1000,
  cond = false,
  enabled = false,
}

return spec
