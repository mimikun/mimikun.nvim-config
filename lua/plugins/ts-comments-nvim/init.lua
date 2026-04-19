---@type LazySpec
local spec = {
  "folke/ts-comments.nvim",
  --lazy = false,
  event = require("plugins.ts-comments-nvim.events"),
  opts = require("plugins.ts-comments-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
