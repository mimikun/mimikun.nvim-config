---@type LazySpec
local spec = {
  "nvim-tree/nvim-tree.lua",
  --lazy = false,
  cmd = require("plugins.nvim-tree-lua.cmds"),
  --keys = require("plugins.nvim-tree-lua.keys"),
  event = require("plugins.nvim-tree-lua.events"),
  dependencies = require("plugins.nvim-tree-lua.dependencies"),
  init = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true
  end,
  --opts = require("plugins.nvim-tree-lua.opts"),
  config = function()
    local opts = require("plugins.nvim-tree-lua.opts")
    require("nvim-tree").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
