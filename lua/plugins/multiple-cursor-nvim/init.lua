---@type LazySpec
local spec = {
  "khoido2003/multiple-cursor.nvim",
  --lazy = false,
  cmd = require("plugins.multiple-cursor-nvim.cmds"),
  --keys = require("plugins.multiple-cursor-nvim.keys"),
  event = require("plugins.multiple-cursor-nvim.events"),
  --opts = require("plugins.multiple-cursor-nvim.opts"),
  config = function()
    local opts = require("plugins.multiple-cursor-nvim.opts")
    require("multiple-cursor").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
