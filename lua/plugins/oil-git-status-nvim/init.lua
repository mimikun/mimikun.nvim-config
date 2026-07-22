---@type LazySpec
local spec = {
  "refractalize/oil-git-status.nvim",
  lazy = false,
  dependencies = require("plugins.oil-git-status-nvim.dependencies"),
  --opts = require("plugins.oil-git-status-nvim.opts"),
  config = function()
    local opts = require("plugins.oil-git-status-nvim.opts")
    require("oil-git-status").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
