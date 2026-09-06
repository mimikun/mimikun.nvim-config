---@type LazySpec
local spec = {
  "phantumblade/projecthub.nvim",
  --lazy = false,
  cmd = require("plugins.projecthub-nvim.cmds"),
  keys = require("plugins.projecthub-nvim.keys"),
  event = require("plugins.projecthub-nvim.events"),
  dependencies = require("plugins.projecthub-nvim.dependencies"),
  --opts = require("plugins.projecthub-nvim.opts"),
  config = function()
    local opts = require("plugins.projecthub-nvim.opts")
    require("projecthub").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
