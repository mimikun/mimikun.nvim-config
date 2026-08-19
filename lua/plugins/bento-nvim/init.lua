---@type LazySpec
local spec = {
  "serhez/bento.nvim",
  --lazy = false,
  cmd = require("plugins.bento-nvim.cmds"),
  --keys = require("plugins.bento-nvim.keys"),
  event = require("plugins.bento-nvim.events"),
  --opts = require("plugins.bento-nvim.opts"),
  config = function()
    local opts = require("plugins.bento-nvim.opts")
    require("bento").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
