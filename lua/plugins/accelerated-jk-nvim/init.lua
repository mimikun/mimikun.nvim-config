---@type LazySpec
local spec = {
  "rainbowhxch/accelerated-jk.nvim",
  --lazy = false,
  event = require("plugins.accelerated-jk-nvim.events"),
  --opts = require("plugins.accelerated-jk-nvim.opts"),
  config = function()
    local opts = require("plugins.accelerated-jk-nvim.opts")
    require("accelerated-jk").setup(opts)

    vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", {})
    vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", {})
  end,
  cond = false,
  enabled = false,
}

return spec
