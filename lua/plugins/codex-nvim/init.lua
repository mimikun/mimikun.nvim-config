---@type LazySpec
local spec = {
  "nwiizo/codex.nvim",
  --lazy = false,
  cmd = require("plugins.codex-nvim.cmds"),
  keys = require("plugins.codex-nvim.keys"),
  event = require("plugins.codex-nvim.events"),
  --opts = require("plugins.codex-nvim.opts"),
  config = function()
    local opts = require("plugins.codex-nvim.opts")
    require("codex").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
