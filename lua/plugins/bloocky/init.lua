---@type LazySpec
local spec = {
  "atiladefreitas/bloocky",
  --lazy = false,
  cmd = require("plugins.bloocky.cmds"),
  keys = require("plugins.bloocky.keys"),
  event = require("plugins.bloocky.events"),
  dependencies = require("plugins.bloocky.dependencies"),
  --opts = require("plugins.bloocky.opts"),
  config = function()
    local opts = require("plugins.bloocky.opts")
    require("bloocky").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
