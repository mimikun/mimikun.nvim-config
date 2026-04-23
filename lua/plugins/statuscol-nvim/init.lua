---@type LazySpec
local spec = {
  "luukvbaal/statuscol.nvim",
  --lazy = false,
  event = require("plugins.statuscol-nvim.events"),
  dependencies = require("plugins.statuscol-nvim.dependencies"),
  --opts = require("plugins.statuscol-nvim.opts"),
  config = function()
    local opts = require("plugins.statuscol-nvim.opts")
    require("statuscol").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
