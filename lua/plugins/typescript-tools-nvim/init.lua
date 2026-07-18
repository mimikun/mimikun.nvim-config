---@type LazySpec
local spec = {
  "pmizio/typescript-tools.nvim",
  --lazy = false,
  --ft = require("plugins.typescript-tools-nvim.ft"),
  cmd = require("plugins.typescript-tools-nvim.cmds"),
  --keys = require("plugins.typescript-tools-nvim.keys"),
  event = require("plugins.typescript-tools-nvim.events"),
  dependencies = require("plugins.typescript-tools-nvim.dependencies"),
  --opts = require("plugins.typescript-tools-nvim.opts"),
  config = function()
    local opts = require("plugins.typescript-tools-nvim.opts")
    require("typescript-tools").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
