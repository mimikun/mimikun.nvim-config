---@type LazySpec
local spec = {
  "vuki656/package-info.nvim",
  --lazy = false,
  cmd = require("plugins.package-info-nvim.cmds"),
  keys = require("plugins.package-info-nvim.keys"),
  event = require("plugins.package-info-nvim.events"),
  dependencies = require("plugins.package-info-nvim.dependencies"),
  --opts = require("plugins.package-info-nvim.opts"),
  config = function()
    local opts = require("plugins.package-info-nvim.opts")
    require("package-info").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
