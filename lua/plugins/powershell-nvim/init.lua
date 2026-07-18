---@type LazySpec
local spec = {
  "TheLeoP/powershell.nvim",
  --lazy = false,
  --ft = require("plugins.powershell-nvim.ft"),
  cmd = require("plugins.powershell-nvim.cmds"),
  --keys = require("plugins.powershell-nvim.keys"),
  event = require("plugins.powershell-nvim.events"),
  dependencies = require("plugins.powershell-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.powershell-nvim.opts"),
  config = function()
    local opts = require("plugins.powershell-nvim.opts")
    require("powershell").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
