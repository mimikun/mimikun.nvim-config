---@type LazySpec
local spec = {
  "xiyaowong/transparent.nvim",
  lazy = false,
  cmd = require("plugins.transparent-nvim.cmds"),
  --opts = require("plugins.transparent-nvim.opts"),
  config = function()
    local opts = require("plugins.transparent-nvim.opts")
    require("transparent").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
