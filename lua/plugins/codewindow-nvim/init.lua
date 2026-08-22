---@type LazySpec
local spec = {
  "starbaser/codewindow.nvim",
  --lazy = false,
  cmd = require("plugins.codewindow-nvim.cmds"),
  keys = require("plugins.codewindow-nvim.keys"),
  event = require("plugins.codewindow-nvim.events"),
  --opts = require("plugins.codewindow-nvim.opts"),
  config = function()
    local opts = require("plugins.codewindow-nvim.opts")
    local codewindow = require("codewindow")

    codewindow.setup(opts)
    codewindow.apply_default_keybinds()
  end,
  --cond = false,
  --enabled = false,
}

return spec
