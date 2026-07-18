---@type LazySpec
local spec = {
  "cordx56/rustowl",
  -- This plugin is already lazy
  lazy = false,
  -- Latest stable version
  version = "*",
  --build = "cargo install rustowl",
  ft = require("plugins.rustowl.ft"),
  cmd = require("plugins.rustowl.cmds"),
  event = require("plugins.rustowl.events"),
  --opts = require("plugins.rustowl.opts"),
  config = function()
    local opts = require("plugins.rustowl.opts")
    require("rustowl").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
