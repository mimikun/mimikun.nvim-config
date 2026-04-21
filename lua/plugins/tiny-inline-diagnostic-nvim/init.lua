---@type LazySpec
local spec = {
  "rachartier/tiny-inline-diagnostic.nvim",
  --lazy = false,
  cmd = require("plugins.tiny-inline-diagnostic-nvim.cmds"),
  keys = require("plugins.tiny-inline-diagnostic-nvim.keys"),
  event = require("plugins.tiny-inline-diagnostic-nvim.events"),
  --opts = require("plugins.tiny-inline-diagnostic-nvim.opts"),
  config = function()
    local opts = require("plugins.tiny-inline-diagnostic-nvim.opts")
    require("tiny-inline-diagnostic").setup(opts)
    -- Disable Neovim's default virtual text diagnostics
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
  priority = 1000,
  --cond = false,
  --enabled = false,
}

return spec
