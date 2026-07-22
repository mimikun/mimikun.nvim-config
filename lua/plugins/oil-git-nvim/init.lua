---@type LazySpec
local spec = {
  "malewicz1337/oil-git.nvim",
  lazy = false,
  dependencies = require("plugins.oil-git-nvim.dependencies"),
  --opts = require("plugins.oil-git-nvim.opts"),
  config = function()
    local opts = require("plugins.oil-git-nvim.opts")
    require("oil-git").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
