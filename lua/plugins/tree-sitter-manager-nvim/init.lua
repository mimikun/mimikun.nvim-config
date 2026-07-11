---@type LazySpec
local spec = {
  "romus204/tree-sitter-manager.nvim",
  --lazy = false,
  cmd = require("plugins.tree-sitter-manager-nvim.cmds"),
  event = require("plugins.tree-sitter-manager-nvim.events"),
  --opts = require("plugins.tree-sitter-manager-nvim.opts"),
  config = function()
    local opts = require("plugins.tree-sitter-manager-nvim.opts")
    require("tree-sitter-manager").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
