---@type LazySpec
local spec = {
  -- Private repository, so lazy.nvim cannot clone it over the default HTTPS
  -- url_format. `dev = true` resolves it under `dev.path` in lua/config/lazy.lua
  -- instead, which is where ghq already put it. The directory is named after the
  -- repository, not after the Lua module.
  "mimikun/mason-nvim-lint.nvim",
  dev = true,
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
