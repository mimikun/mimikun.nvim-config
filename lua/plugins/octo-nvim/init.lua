---@type LazySpec
local spec = {
  "pwntester/octo.nvim",
  --lazy = false,
  cmd = require("plugins.octo-nvim.cmds"),
  keys = require("plugins.octo-nvim.keys"),
  event = require("plugins.octo-nvim.events"),
  dependencies = require("plugins.octo-nvim.dependencies"),
  --opts = require("plugins.octo-nvim.opts"),
  config = function()
    local opts = require("plugins.octo-nvim.opts")
    require("octo").setup(opts)
    -- Use treesitter markdown parser with octo buffers
    vim.treesitter.language.register("markdown", "octo")
    --    INIT
  end,
  --cond = false,
  --enabled = false,
}

return spec
