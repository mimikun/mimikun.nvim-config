---@type LazySpec
local spec = {
  "mvllow/modes.nvim",
  --lazy = false,
  --tag = "v0.2.1",
  event = require("plugins.modes-nvim.events"),
  --opts = require("plugins.modes-nvim.opts"),
  config = function()
    local opts = require("plugins.modes-nvim.opts")
    require("modes").setup(opts)
    -- WORKAROUND: Press ENTER" prompt shows when entering vim
    -- Set cmdheight AFTER modes setup
    --vim.o.cmdheight = 0
  end,
  --cond = false,
  --enabled = false,
}

return spec
