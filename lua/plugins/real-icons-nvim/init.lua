---@type LazySpec
local spec = {
  "Mirsmog/real-icons.nvim",
  --lazy = false,
  build = ":RealIcons install",
  cmd = require("plugins.real-icons-nvim.cmds"),
  event = require("plugins.real-icons-nvim.events"),
  dependencies = require("plugins.real-icons-nvim.dependencies"),
  --opts = require("plugins.real-icons-nvim.opts"),
  config = function()
    local opts = require("plugins.real-icons-nvim.opts")
    require("real-icons").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
