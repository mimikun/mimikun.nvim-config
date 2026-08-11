---@type LazySpec
local spec = {
  "saghen/blink.lib",
  --lazy = false,
  cmd = require("plugins.blink-lib.cmds"),
  event = require("plugins.blink-lib.events"),
  --cond = false,
  --enabled = false,
}

return spec
