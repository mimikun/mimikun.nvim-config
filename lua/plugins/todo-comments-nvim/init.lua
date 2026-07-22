---@type LazySpec
local spec = {
  "folke/todo-comments.nvim",
  --lazy = false,
  cmd = require("plugins.todo-comments-nvim.cmds"),
  keys = require("plugins.todo-comments-nvim.keys"),
  event = require("plugins.todo-comments-nvim.events"),
  dependencies = require("plugins.todo-comments-nvim.dependencies"),
  --opts = require("plugins.todo-comments-nvim.opts"),
  config = function()
    local opts = require("plugins.todo-comments-nvim.opts")
    require("todo-comments").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
