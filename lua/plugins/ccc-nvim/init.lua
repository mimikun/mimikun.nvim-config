---@type LazySpec
local spec = {
  "uga-rosa/ccc.nvim",
  --lazy = false,
  cmd = require("plugins.ccc-nvim.cmds"),
  event = require("plugins.ccc-nvim.events"),
  init = function()
    -- Enable true color
    vim.opt.termguicolors = true
  end,
  --opts = require("plugins.ccc-nvim.opts"),
  config = function()
    local opts = require("plugins.ccc-nvim.opts")
    require("ccc").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
