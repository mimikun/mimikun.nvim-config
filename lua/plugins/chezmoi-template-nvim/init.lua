---@type LazySpec
local spec = {
  "dpezto/chezmoi-template.nvim",
  lazy = false,
  cmd = require("plugins.chezmoi-template-nvim.cmds"),
  keys = require("plugins.chezmoi-template-nvim.keys"),
  event = require("plugins.chezmoi-template-nvim.events"),
  dependencies = require("plugins.chezmoi-template-nvim.dependencies"),
  --opts = require("plugins.chezmoi-template-nvim.opts"),
  config = function()
    local opts = require("plugins.chezmoi-template-nvim.opts")
    require("chezmoi-template").setup(opts)
    --vim.g.chezmoi_template = opts
    --require("chezmoi-template.icons").attach()
  end,
  --cond = false,
  --enabled = false,
}

return spec
