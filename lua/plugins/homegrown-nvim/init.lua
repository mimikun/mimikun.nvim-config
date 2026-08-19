---@type LazySpec
local spec = {
  "2KAbhishek/homegrown.nvim",
  --lazy = false,
  cmd = require("plugins.homegrown-nvim.cmds"),
  event = require("plugins.homegrown-nvim.events"),
  dependencies = require("plugins.homegrown-nvim.dependencies"),
  --opts = require("plugins.homegrown-nvim.opts"),
  config = function()
    local opts = require("plugins.homegrown-nvim.opts")
    require("homegrown").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
