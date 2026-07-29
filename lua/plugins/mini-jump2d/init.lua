---@type LazySpec
local spec = {
  "nvim-mini/mini.jump2d",
  --lazy = false,
  --keys = require("plugins.mini-jump2d.keys"),
  event = require("plugins.mini-jump2d.events"),
  --opts = require("plugins.mini-jump2d.opts"),
  config = function()
    local opts = require("plugins.mini-jump2d.opts")
    require("mini.jump2d").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
