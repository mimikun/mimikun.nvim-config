---@type LazySpec
local spec = {
  "jjuchara/obsidian-tasks.nvim",
  --lazy = false,
  cmd = require("plugins.obsidian-tasks-nvim.cmds"),
  keys = require("plugins.obsidian-tasks-nvim.keys"),
  event = require("plugins.obsidian-tasks-nvim.events"),
  --opts = require("plugins.obsidian-tasks-nvim.opts"),
  config = function()
    local opts = require("plugins.obsidian-tasks-nvim.opts")
    require("obsidian-tasks").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
