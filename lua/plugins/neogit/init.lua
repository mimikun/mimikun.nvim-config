---@type LazySpec
local spec = {
  "NeogitOrg/neogit",
  --lazy = false,
  cmd = require("plugins.neogit.cmds"),
  keys = require("plugins.neogit.keys"),
  event = require("plugins.neogit.events"),
  dependencies = require("plugins.neogit.dependencies"),
  --opts = require("plugins.neogit.opts"),
  config = function()
    local opts = require("plugins.neogit.opts")
    require("neogit").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
