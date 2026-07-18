---@type LazySpec
local spec = {
  "SunnyTamang/select-undo.nvim",
  --lazy = false,
  cmd = require("plugins.select-undo-nvim.cmds"),
  keys = require("plugins.select-undo-nvim.keys"),
  event = require("plugins.select-undo-nvim.events"),
  --opts = require("plugins.select-undo-nvim.opts"),
  config = function()
    local opts = require("plugins.select-undo-nvim.opts")
    require("select-undo").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
