---@type LazySpec
local spec = {
  "kuri-sun/todoage.nvim",
  --lazy = false,
  cmd = require("plugins.todoage-nvim.cmds"),
  event = require("plugins.todoage-nvim.events"),
  --opts = require("plugins.todoage-nvim.opts"),
  config = function()
    local opts = require("plugins.todoage-nvim.opts")
    require("todoage").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
