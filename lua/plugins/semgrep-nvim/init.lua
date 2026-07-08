---@type LazySpec
local spec = {
  "tumillanino/semgrep.nvim",
  --lazy = false,
  cmd = require("plugins.semgrep-nvim.cmds"),
  event = require("plugins.semgrep-nvim.events"),
  dependencies = require("plugins.semgrep-nvim.dependencies"),
  --opts = require("plugins.semgrep-nvim.opts"),
  config = function()
    local opts = require("plugins.semgrep-nvim.opts")
    require("semgrep").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
