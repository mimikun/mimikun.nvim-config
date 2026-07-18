---@type LazySpec
local spec = {
  "Civitasv/cmake-tools.nvim",
  --lazy = false,
  --ft = require("plugins.cmake-tools-nvim.ft"),
  cmd = require("plugins.cmake-tools-nvim.cmds"),
  --keys = require("plugins.cmake-tools-nvim.keys"),
  event = require("plugins.cmake-tools-nvim.events"),
  dependencies = require("plugins.cmake-tools-nvim.dependencies"),
  --opts = require("plugins.cmake-tools-nvim.opts"),
  config = function()
    local opts = require("plugins.cmake-tools-nvim.opts")
    require("cmake-tools").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
