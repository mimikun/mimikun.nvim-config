---@type LazySpec
local spec = {
  "rcarriga/nvim-notify",
  --lazy = false,
  cmd = require("plugins.nvim-notify.cmds"),
  event = require("plugins.nvim-notify.events"),
  dependencies = require("plugins.nvim-notify.dependencies"),
  init = function()
    vim.opt.termguicolors = true
  end,
  --opts = require("plugins.nvim-notify.opts"),
  config = function()
    local opts = require("plugins.nvim-notify.opts")
    require("notify").setup(opts)

    require("telescope").load_extension("notify")
  end,
  --cond = false,
  --enabled = false,
}

return spec
