---@type LazySpec
local spec = {
  "nvim-lualine/lualine.nvim",
  --lazy = false,
  cmd = require("plugins.lualine-nvim.cmds"),
  event = require("plugins.lualine-nvim.events"),
  dependencies = require("plugins.lualine-nvim.dependencies"),
  opts = require("plugins.lualine-nvim.opts"),
  --config = function()
  --    INIT
  --end,
  --cond = false,
  --enabled = false,
}

return spec
