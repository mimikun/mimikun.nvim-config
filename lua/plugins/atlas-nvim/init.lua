---@type LazySpec
local spec = {
  "emrearmagan/atlas.nvim",
  --lazy = false,
  cmd = require("plugins.atlas-nvim.cmds"),
  --keys = require("plugins.atlas-nvim.keys"),
  event = require("plugins.atlas-nvim.events"),
  dependencies = require("plugins.atlas-nvim.dependencies"),
  --opts = require("plugins.atlas-nvim.opts"),
  config = function()
    local opts = require("plugins.atlas-nvim.opts")
    require("atlas").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
