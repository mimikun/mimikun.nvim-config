---@type LazySpec
local spec = {
  "willothy/nvim-cokeline",
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
  --ft = require("plugins.nvim-cokeline.ft"),
  --cmd = require("plugins.nvim-cokeline.cmds"),
  keys = require("plugins.nvim-cokeline.keys"),
  event = require("plugins.nvim-cokeline.events"),
  dependencies = require("plugins.nvim-cokeline.dependencies"),
  init = function()
    -- cokeline reads hex gui values, so truecolor is a hard requirement
    vim.opt.termguicolors = true
    -- cokeline sets this itself on load, but keep the requirement visible here
    vim.opt.showtabline = 2
  end,
  --opts = require("plugins.nvim-cokeline.opts"),
  config = function()
    local opts = require("plugins.nvim-cokeline.opts")
    require("cokeline").setup(opts)
  end,
  --priority = 1000,
  --cond = false,
  --enabled = false,
}

return spec
