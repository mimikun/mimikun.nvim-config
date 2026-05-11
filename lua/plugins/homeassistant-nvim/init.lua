---@type LazySpec
local spec = {
  "myakove/homeassistant-nvim",
  --lazy = false,
  cmd = require("plugins.homeassistant-nvim.cmds"),
  keys = require("plugins.homeassistant-nvim.keys"),
  event = require("plugins.homeassistant-nvim.events"),
  dependencies = require("plugins.homeassistant-nvim.dependencies"),
  --opts = require("plugins.homeassistant-nvim.opts"),
  config = function()
    local opts = require("plugins.homeassistant-nvim.opts")
    require("homeassistant").setup(opts)
  end,
  -- TODO: it
  cond = false,
  enabled = false,
}

return spec
