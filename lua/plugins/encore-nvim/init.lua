---@type LazySpec
local spec = {
  "XXiaoA/encore.nvim",
  --lazy = false,
  cmd = require("plugins.encore-nvim.cmds"),
  event = require("plugins.encore-nvim.events"),
  --opts = require("plugins.encore-nvim.opts"),
  config = function()
    local opts = require("plugins.encore-nvim.opts")
    require("encore").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
