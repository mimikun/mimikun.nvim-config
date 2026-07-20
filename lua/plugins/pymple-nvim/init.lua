---@type LazySpec
local spec = {
  "alexpasmantier/pymple.nvim",
  --lazy = false,
  build = ":PympleBuild",
  --ft = require("plugins.pymple-nvim.ft"),
  --cmd = require("plugins.pymple-nvim.cmds"),
  --keys = require("plugins.pymple-nvim.keys"),
  --event = require("plugins.pymple-nvim.events"),
  --dependencies = require("plugins.pymple-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.pymple-nvim.opts"),
  config = function()
    local opts = require("plugins.pymple-nvim.opts")
    require("pymple").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
