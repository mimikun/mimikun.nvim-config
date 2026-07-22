---@type LazySpec
local spec = {
  "sphamba/smear-cursor.nvim",
  --lazy = false,
  cmd = require("plugins.smear-cursor-nvim.cmds"),
  event = require("plugins.smear-cursor-nvim.events"),
  --opts = require("plugins.smear-cursor-nvim.opts"),
  config = function()
    local opts = require("plugins.smear-cursor-nvim.opts")
    require("smear_cursor").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
