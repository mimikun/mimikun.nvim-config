---@type LazySpec
local spec = {
  "zaakiy/line-justice.nvim",
  --lazy = false,
  event = require("plugins.line-justice-nvim.events"),
  dependencies = require("plugins.line-justice-nvim.dependencies"),
  --opts = require("plugins.line-justice-nvim.opts"),
  config = function()
    local opts = require("plugins.line-justice-nvim.opts")
    require("line-justice").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
