---@type LazySpec
local spec = {
  "saecki/crates.nvim",
  --lazy = false,
  --tag = "stable",
  cmd = require("plugins.crates-nvim.cmds"),
  keys = require("plugins.crates-nvim.keys"),
  event = require("plugins.crates-nvim.events"),
  opts = require("plugins.crates-nvim.opts"),
  --config = function()
  --local opts = require("plugins.crates-nvim.opts")
  --require("crates").setup(opts)
  --end,
  --cond = false,
  --enabled = false,
}

return spec
