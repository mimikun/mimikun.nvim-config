---@type LazySpec
local spec = {
  "monaqa/dial.nvim",
  --lazy = false,
  --ft = require("plugins.dial-nvim.ft"),
  cmd = require("plugins.dial-nvim.cmds"),
  keys = require("plugins.dial-nvim.keys"),
  --event = require("plugins.dial-nvim.events"),
  --dependencies = require("plugins.dial-nvim.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("plugins.dial-nvim.opts"),
  config = function()
    --    INIT
  end,
  --cond = false,
  --enabled = false,
}

return spec
