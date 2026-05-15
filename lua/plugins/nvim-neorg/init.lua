---@type LazySpec
local spec = {
  "nvim-neorg/neorg",
  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  lazy = false,
  -- Pin Neorg to the latest stable release
  version = "*",
  --ft = require("plugins.nvim-neorg.ft"),
  --cmd = require("plugins.nvim-neorg.cmds"),
  --keys = require("plugins.nvim-neorg.keys"),
  --event = require("plugins.nvim-neorg.events"),
  --dependencies = require("plugins.nvim-neorg.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.nvim-neorg.opts"),
  config = function()
    local opts = require("plugins.nvim-neorg.opts")
    require("neorg").setup(opts)
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
  --cond = false,
  --enabled = false,
}

return spec
