---@type LazySpec
local spec = {
  "atiladefreitas/dooing",
  --lazy = false,
  cmd = require("plugins.dooing.cmds"),
  keys = require("plugins.dooing.keys"),
  event = require("plugins.dooing.events"),
  --opts = require("plugins.dooing.opts"),
  config = function()
    local opts = require("plugins.dooing.opts")
    require("dooing").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
