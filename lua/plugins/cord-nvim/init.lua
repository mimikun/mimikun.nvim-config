---@type LazySpec
local spec = {
  "vyfor/cord.nvim",
  --lazy = false,
  cmd = require("plugins.cord-nvim.cmds"),
  keys = require("plugins.cord-nvim.keys"),
  event = require("plugins.cord-nvim.events"),
  init = function()
    vim.g.cord_defer_startup = true
  end,
  --opts = require("plugins.cord-nvim.opts"),
  config = function()
    local opts = require("plugins.cord-nvim.opts")
    require("cord").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
