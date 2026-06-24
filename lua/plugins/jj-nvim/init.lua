---@type LazySpec
local spec = {
  "NicolasGB/jj.nvim",
  --lazy = false,
  -- Use latest stable release
  --version = "*",
  -- Or from the main branch (uncomment the branch line and comment the version line)
  --branch = "main",
  --ft = require("plugins.jj-nvim.ft"),
  cmd = require("plugins.jj-nvim.cmds"),
  --keys = require("plugins.jj-nvim.keys"),
  event = require("plugins.jj-nvim.events"),
  dependencies = require("plugins.jj-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.jj-nvim.opts"),
  config = function()
    --local opts = require("plugins.jj-nvim.opts")
    require("jj").setup()
  end,
  --cond = false,
  --enabled = false,
}

return spec
