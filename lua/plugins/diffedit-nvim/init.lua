---@type LazySpec
local spec = {
  "djakidjo/diffedit.nvim",
  --lazy = false,
  ft = require("plugins.diffedit-nvim.ft"),
  cmd = require("plugins.diffedit-nvim.cmds"),
  event = require("plugins.diffedit-nvim.events"),
  --opts = require("plugins.diffedit-nvim.opts"),
  config = function()
    local opts = require("plugins.diffedit-nvim.opts")
    require("diffedit").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
