---@type LazySpec
local spec = {
  "willothy/lockfile.nvim",
  --lazy = false,
  build = function()
    require("lockfile.download").download_or_build()
  end,
  cmd = require("plugins.lockfile-nvim.cmds"),
  event = require("plugins.lockfile-nvim.events"),
  --opts = require("plugins.lockfile-nvim.opts")
  config = function()
    local opts = require("plugins.lockfile-nvim.opts")
    require("lockfile").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
