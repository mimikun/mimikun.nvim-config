---@type LazySpec
local spec = {
        'akinsho/toggleterm.nvim', 
  --lazy = false,
  --dir = ""
  --url = ""
  --name = ""
  --dev = false
  --build = "",
  --branch = "",
  --tag = "",
  --commit = "",
        version = "*", 
  --ft = require("plugins.toggleterm-nvim.ft"),
  --cmd = require("plugins.toggleterm-nvim.cmds"),
  --keys = require("plugins.toggleterm-nvim.keys"),
  --event = require("plugins.toggleterm-nvim.events"),
  --dependencies = require("plugins.toggleterm-nvim.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("plugins.toggleterm-nvim.opts"),
  config = function()
  local opts = require("plugins.toggleterm-nvim.opts")
  require("toggleterm").setup(opts)
  end,
  --main = ""
  --pin = false,
  --submodules = false,
  --module = false,
  --priority = 1000,
  --optional = false,
  cond = false,
  enabled = false,
}

return spec
