---@type LazySpec
local spec = {
  "eduardofuncao/squix.nvim",
  --lazy = false,
  cmd = require("plugins.squix-nvim.cmds"),
  keys = require("plugins.squix-nvim.keys"),
  event = require("plugins.squix-nvim.events"),
  --opts = require("plugins.squix-nvim.opts"),
  config = function()
    local opts = require("plugins.squix-nvim.opts")
    require("squix").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
