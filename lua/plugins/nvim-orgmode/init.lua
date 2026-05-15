---@type LazySpec
local spec = {
  "nvim-orgmode/orgmode",
  --lazy = false,
  ft = require("plugins.nvim-orgmode.ft"),
  --cmd = require("plugins.nvim-orgmode.cmds"),
  --keys = require("plugins.nvim-orgmode.keys"),
  event = require("plugins.nvim-orgmode.events"),
  --dependencies = require("plugins.nvim-orgmode.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.nvim-orgmode.opts"),
  config = function()
    local opts = require("plugins.nvim-orgmode.opts")
    require("orgmode").setup(opts)

    -- Experimental LSP support
    vim.lsp.enable("org")
  end,
  cond = false,
  enabled = false,
}

return spec
