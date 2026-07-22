---@type LazySpec
local spec = {
  "renerocksai/telekasten.nvim",
  --lazy = false,
  cmd = require("plugins.telekasten-nvim.cmds"),
  keys = require("plugins.telekasten-nvim.keys"),
  event = require("plugins.telekasten-nvim.events"),
  dependencies = require("plugins.telekasten-nvim.dependencies"),
  --opts = require("plugins.telekasten-nvim.opts"),
  init = function()
    -- Register markdown treesitter parser for telekasten filetype so nvim-treesitter highlights .md files opened through telekasten
    vim.treesitter.language.register("markdown", "telekasten")
  end,
  config = function()
    local opts = require("plugins.telekasten-nvim.opts")
    require("telekasten").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
