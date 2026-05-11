---@type LazySpec
local spec = {
  "SmiteshP/nvim-navbuddy",
  --lazy = false,
  cmd = require("plugins.nvim-navbuddy.cmds"),
  event = require("plugins.nvim-navbuddy.events"),
  dependencies = require("plugins.nvim-navbuddy.dependencies"),
  --opts = require("plugins.nvim-navbuddy.opts"),
  config = function()
    local opts = require("plugins.nvim-navbuddy.opts")
    require("nvim-navbuddy").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
