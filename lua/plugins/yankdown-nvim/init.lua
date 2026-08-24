---@type LazySpec
local spec = {
  "ntk148v/yankdown.nvim",
  --lazy = false,
  ft = require("plugins.yankdown-nvim.ft"),
  cmd = require("plugins.yankdown-nvim.cmds"),
  keys = require("plugins.yankdown-nvim.keys"),
  event = require("plugins.yankdown-nvim.events"),
  --opts = require("plugins.yankdown-nvim.opts"),
  config = function()
    local opts = require("plugins.yankdown-nvim.opts")
    require("yankdown").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
