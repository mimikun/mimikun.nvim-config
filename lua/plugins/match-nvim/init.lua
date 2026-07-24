---@type LazySpec
local spec = {
  "ankushbhagats/match.nvim",
  --lazy = false,
  cmd = require("plugins.match-nvim.cmds"),
  event = require("plugins.match-nvim.events"),
  config = function()
    local opts = require("plugins.match-nvim.opts")
    require("match").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
