---@type LazySpec
local spec = {
  "josephburgess/nvumi",
  --lazy = false,
  ft = require("plugins.nvumi.ft"),
  cmd = require("plugins.nvumi.cmds"),
  keys = require("plugins.nvumi.keys"),
  event = require("plugins.nvumi.events"),
  --opts = require("plugins.nvumi.opts"),
  config = function()
    local opts = require("plugins.nvumi.opts")
    require("nvumi").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
