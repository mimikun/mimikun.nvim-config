---@type LazySpec
local spec = {
  "elixir-tools/elixir-tools.nvim",
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
  --ft = require("plugins.elixir-tools-nvim.ft"),
  --ft = require("denops-plugins.elixir-tools-nvim.ft"),
  --cmd = require("plugins.elixir-tools-nvim.cmds"),
  --cmd = require("denops-plugins.elixir-tools-nvim.cmds"),
  --keys = require("plugins.elixir-tools-nvim.keys"),
  --keys = require("denops-plugins.elixir-tools-nvim.keys"),
  --event = require("plugins.elixir-tools-nvim.events"),
  --event = require("denops-plugins.elixir-tools-nvim.events"),
  --dependencies = require("plugins.elixir-tools-nvim.dependencies"),
  --dependencies = require("denops-plugins.elixir-tools-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.elixir-tools-nvim.opts"),
  --opts = require("denops-plugins.elixir-tools-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.elixir-tools-nvim.opts")
  --  local opts = require("denops-plugins.elixir-tools-nvim.opts")
  --end,
  --priority = 1000,
  cond = false,
  enabled = false,
}

return spec
-- :%s/elixir-tools-nvim/
