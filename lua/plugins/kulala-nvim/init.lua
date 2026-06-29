---@type LazySpec
local spec = {
  "mistweaverco/kulala.nvim",
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
  ft = require("plugins.kulala-nvim.ft"),
  --cmd = require("plugins.kulala-nvim.cmds"),
  --keys = require("plugins.kulala-nvim.keys"),
  --event = require("plugins.kulala-nvim.events"),
  --dependencies = require("plugins.kulala-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.kulala-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.kulala-nvim.opts")
  --end,
  --cond = false,
  --enabled = false,
}

return spec
