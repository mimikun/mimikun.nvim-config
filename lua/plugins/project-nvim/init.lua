---@type LazySpec
local spec = {
  "DrKJeff16/project.nvim",
  --lazy = false,
  cmd = require("plugins.project-nvim.cmds"),
  event = require("plugins.project-nvim.events"),
  dependencies = require("plugins.project-nvim.dependencies"),
  --opts = require("plugins.project-nvim.opts"),
  config = function()
    local opts = require("plugins.project-nvim.opts")
    require("project").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
