---@type LazySpec
local spec = {
  "DrKJeff16/project.nvim",
  --lazy = false,
  --ft = require("plugins.project-nvim.ft"),
  cmd = require("plugins.project-nvim.cmds"),
  --keys = require("plugins.project-nvim.keys"),
  --event = require("plugins.project-nvim.events"),
  dependencies = require("plugins.project-nvim.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("plugins.project-nvim.opts"),
  config = function()
    local opts = require("plugins.project-nvim.opts")
    require("project").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
