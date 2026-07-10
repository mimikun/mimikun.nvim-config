---@type LazySpec
local spec = {
  "rvaccone/wind.nvim",
  --lazy = false,
  cmd = require("plugins.wind-nvim.cmds"),
  --keys = require("plugins.wind-nvim.keys"),
  event = require("plugins.wind-nvim.events"),
  --opts = require("plugins.wind-nvim.opts"),
  config = function()
    local opts = require("plugins.wind-nvim.opts")
    require("wind").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
