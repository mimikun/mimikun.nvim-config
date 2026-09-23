---@type LazySpec
local spec = {
  "blackhat-7/vellum.nvim",
  --lazy = false,
  ft = require("plugins.vellum-nvim.ft"),
  cmd = require("plugins.vellum-nvim.cmds"),
  keys = require("plugins.vellum-nvim.keys"),
  event = require("plugins.vellum-nvim.events"),
  --opts = require("plugins.vellum-nvim.opts"),
  config = function()
    local opts = require("plugins.vellum-nvim.opts")
    require("vellum").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
