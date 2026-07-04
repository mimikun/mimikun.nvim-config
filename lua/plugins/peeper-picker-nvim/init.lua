---@type LazySpec
local spec = {
  "parwest/peeper-picker.nvim",
  main = "peeper_picker",
  --lazy = false,
  cmd = require("plugins.peeper-picker-nvim.cmds"),
  keys = require("plugins.peeper-picker-nvim.keys"),
  event = require("plugins.peeper-picker-nvim.events"),
  --opts = require("plugins.peeper-picker-nvim.opts"),
  config = function()
    local opts = require("plugins.peeper-picker-nvim.opts")
    require("peeper_picker").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
