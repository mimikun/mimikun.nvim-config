---@type LazySpec
local spec = {
  "nvim-telescope/telescope.nvim",
  --lazy = false,
  --version = "*",
  cmd = require("plugins.telescope-nvim.cmds"),
  keys = require("plugins.telescope-nvim.keys"),
  event = require("plugins.telescope-nvim.events"),
  dependencies = require("plugins.telescope-nvim.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("plugins.telescope-nvim.opts"),
  config = function()
    local opts = require("plugins.telescope-nvim.opts")
    local telescope = require("telescope")

    telescope.setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
