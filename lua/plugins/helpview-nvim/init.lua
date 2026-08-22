---@type LazySpec
local spec = {
  "OXY2DEV/helpview.nvim",
  lazy = false,
  --branch = "dev",
  submodules = false,
  cmd = require("plugins.helpview-nvim.cmds"),
  event = require("plugins.helpview-nvim.events"),
  dependencies = require("plugins.helpview-nvim.dependencies"),
  --opts = require("plugins.helpview-nvim.opts"),
  config = function()
    local opts = require("plugins.helpview-nvim.opts")
    require("helpview").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
