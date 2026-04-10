---@type LazySpec
local spec = {
  "rachartier/tiny-cmdline.nvim",
  --lazy = false,
  event = require("plugins.tiny-cmdline-nvim.events"),
  init = function()
    --vim.o.cmdheight = 0
    require("vim._core.ui2").enable({})

    local opts = require("plugins.tiny-cmdline-nvim.opts")

    vim.g.tiny_cmdline = opts
  end,
  --cond = false,
  --enabled = false,
}

return spec
