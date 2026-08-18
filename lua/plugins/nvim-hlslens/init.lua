---@type LazySpec
local spec = {
  "kevinhwang91/nvim-hlslens",
  --lazy = false,
  cmd = require("plugins.nvim-hlslens.cmds"),
  keys = require("plugins.nvim-hlslens.keys"),
  event = require("plugins.nvim-hlslens.events"),
  dependencies = require("plugins.nvim-hlslens.dependencies"),
  --opts = require("plugins.nvim-hlslens.opts"),
  config = function()
    local opts = require("plugins.nvim-hlslens.opts")
    require("hlslens").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
