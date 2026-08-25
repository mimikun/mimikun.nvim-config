---@type LazySpec
local spec = {
  "OXY2DEV/markview.nvim",
  --lazy = false,
  --ft = require("plugins.markview-nvim.ft"),
  cmd = require("plugins.markview-nvim.cmds"),
  --keys = require("plugins.markview-nvim.keys"),
  event = require("plugins.markview-nvim.events"),
  --dependencies = require("plugins.markview-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.markview-nvim.opts"),
  config = function()
    local opts = require("plugins.markview-nvim.opts")
    require("markview").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
