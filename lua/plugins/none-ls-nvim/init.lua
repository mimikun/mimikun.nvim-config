---@type LazySpec
local spec = {
  "nvimtools/none-ls.nvim",
  --lazy = false,
  cmd = require("plugins.none-ls-nvim.cmds"),
  --keys = require("plugins.none-ls-nvim.keys"),
  event = require("plugins.none-ls-nvim.events"),
  dependencies = require("plugins.none-ls-nvim.dependencies"),
  --opts = require("plugins.none-ls-nvim.opts"),
  config = function()
    local opts = require("plugins.none-ls-nvim.opts")
    require("null-ls").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
