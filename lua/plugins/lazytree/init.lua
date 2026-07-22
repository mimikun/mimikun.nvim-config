---@type LazySpec
local spec = {
  "TomDeneire/lazytree",
  --lazy = false,
  cmd = require("plugins.lazytree.cmds"),
  event = require("plugins.lazytree.events"),
  opts = require("plugins.lazytree.opts"),
  --cond = false,
  --enabled = false,
}

return spec
