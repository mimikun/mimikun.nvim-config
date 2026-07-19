---@type LazySpec
local spec = {
  "ergodice/hamal.nvim",
  --lazy = false,
  keys = require("plugins.hamal-nvim.keys"),
  event = require("plugins.hamal-nvim.events"),
  --opts = require("plugins.hamal-nvim.opts"),
  config = function()
    local opts = require("plugins.hamal-nvim.opts")
    require("hamal").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
