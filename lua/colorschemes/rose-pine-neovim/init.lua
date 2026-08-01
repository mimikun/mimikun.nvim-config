---@type LazySpec
local spec = {
  "rose-pine/neovim",
  name = "rose-pine",
  --lazy = false,
  event = require("colorschemes.rose-pine-neovim.events"),
  --dependencies = require("colorschemes.rose-pine-neovim.dependencies"),
  --opts = require("colorschemes.rose-pine-neovim.opts"),
  config = function()
    local opts = require("colorschemes.rose-pine-neovim.opts")
    require("rose-pine").setup(opts)
    --vim.cmd.colorscheme("rose-pine")
    --vim.cmd.colorscheme("rose-pine-main")
    --vim.cmd.colorscheme("rose-pine-moon")
    --vim.cmd.colorscheme("rose-pine-dawn")
  end,
  priority = 1000,
  cond = false,
  enabled = false,
}

return spec
