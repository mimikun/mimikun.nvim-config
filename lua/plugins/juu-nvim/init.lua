---@type LazySpec
local spec = {
  "mistweaverco/juu.nvim",
  --lazy = false,
  cmd = require("plugins.juu-nvim.cmds"),
  --keys = require("plugins.juu-nvim.keys"),
  event = require("plugins.juu-nvim.events"),
  --dependencies = require("plugins.juu-nvim.dependencies"),
  init = function()
    -- Required for the command line to work
    require("vim._core.ui2").enable({})
  end,
  --opts = require("plugins.juu-nvim.opts"),
  config = function()
    local opts = require("plugins.juu-nvim.opts")
    require("juu").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
