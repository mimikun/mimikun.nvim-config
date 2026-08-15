---@type LazySpec
local spec = {
  "olimorris/codecompanion.nvim",
  --lazy = false,
  --url = "",
  --name = "",
  --dev = false,
  --dir = "",
  --build = "",
  --branch = "",
  --tag = "",
  --version = "",
  --commit = "",
  --main = "",
  --pin = false,
  --submodules = false,
  --module = false,
  --optional = false,
  --ft = require("plugins.codecompanion-nvim.ft"),
  --cmd = require("plugins.codecompanion-nvim.cmds"),
  --keys = require("plugins.codecompanion-nvim.keys"),
  --event = require("plugins.codecompanion-nvim.events"),
  --dependencies = require("plugins.codecompanion-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.codecompanion-nvim.opts"),
  config = function()
    local opts = require("plugins.codecompanion-nvim.opts")
    require("codecompanion").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
-- :%s/codecompanion-nvim/
