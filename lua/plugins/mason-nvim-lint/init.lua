---@type LazySpec
local spec = {
  -- Local checkout while this is being developed. Swap for "mimikun/mason-nvim-lint"
  -- once it is pushed.
  dir = vim.fn.expand("~/ghq/github.com/mimikun/mason-nvim-lint"),
  name = "mason-nvim-lint",
  --lazy = false,
  dependencies = require("plugins.mason-nvim-lint.dependencies"),
  cmd = require("plugins.mason-nvim-lint.cmds"),
  event = require("plugins.mason-nvim-lint.events"),
  --opts = require("plugins.mason-nvim-lint.opts"),
  config = function()
    local opts = require("plugins.mason-nvim-lint.opts")
    require("mason-nvim-lint").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
