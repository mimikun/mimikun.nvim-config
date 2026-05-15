---@type LazySpec
local spec = {
  "uga-rosa/ccc.nvim",
  --lazy = false,
  cmd = require("plugins.ccc-nvim.cmds"),
  --keys = require("plugins.ccc-nvim.keys"),
  --event = require("plugins.ccc-nvim.events"),
  --dependencies = require("plugins.ccc-nvim.dependencies"),
  init = function()
    -- Enable true color
    vim.opt.termguicolors = true
  end,
  --opts = require("plugins.ccc-nvim.opts"),
  config = function()
    local opts = require("plugins.ccc-nvim.opts")
    local ccc = require("ccc")
    local mapping = ccc.mapping

    ccc.setup({
      -- Your preferred settings
      -- Example: enable highlighter
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
