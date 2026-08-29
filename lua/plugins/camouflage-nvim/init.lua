---@type LazySpec
local spec = {
  "zeybek/camouflage.nvim",
  --lazy = false,
  cmd = require("plugins.camouflage-nvim.cmds"),
  keys = require("plugins.camouflage-nvim.keys"),
  event = require("plugins.camouflage-nvim.events"),
  --dependencies = require("plugins.camouflage-nvim.dependencies"),
  --opts = require("plugins.camouflage-nvim.opts"),
  config = function()
    local opts = require("plugins.camouflage-nvim.opts")
    require("camouflage").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
