---@type LazySpec
local spec = {
  "obsidian-nvim/obsidian.nvim",
  --lazy = false,
  -- use latest release, remove to use latest commit
  version = "*",
  cmd = require("plugins.obsidian-nvim.cmds"),
  keys = require("plugins.obsidian-nvim.keys"),
  event = require("plugins.obsidian-nvim.events"),
  dependencies = require("plugins.obsidian-nvim.dependencies"),
  --opts = require("plugins.obsidian-nvim.opts"),
  config = function()
    local opts = require("plugins.obsidian-nvim.opts")
    require("obsidian").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
