---@type LazySpec
local spec = {
  "ph1losof/shelter.nvim",
  lazy = false,
  cmd = require("plugins.shelter-nvim.cmds"),
  event = require("plugins.shelter-nvim.events"),
  dependencies = require("plugins.shelter-nvim.dependencies"),
  --opts = require("plugins.shelter-nvim.opts"),
  config = function()
    local opts = require("plugins.shelter-nvim.opts")
    require("shelter").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
