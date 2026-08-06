---@type LazySpec
local spec = {
  -- Private repository, so lazy.nvim cannot clone it over the default HTTPS
  -- url_format. `dev = true` resolves it under `dev.path` in lua/config/lazy.lua
  -- instead, which is where ghq already put it.
  "mimikun/mason-conform.nvim",
  dev = true,
  --lazy = false,
  dependencies = require("plugins.mason-conform-nvim.dependencies"),
  cmd = require("plugins.mason-conform-nvim.cmds"),
  event = require("plugins.mason-conform-nvim.events"),
  --opts = require("plugins.mason-conform-nvim.opts"),
  config = function()
    local opts = require("plugins.mason-conform-nvim.opts")
    require("mason-conform").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
