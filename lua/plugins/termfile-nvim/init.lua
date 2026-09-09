---@type LazySpec
local spec = {
  "TheLazyCat00/termfile-nvim",
  --lazy = false,
  event = require("plugins.termfile-nvim.events"),
  --opts = require("plugins.termfile-nvim.opts"),
  config = function()
    local opts = require("plugins.termfile-nvim.opts")
    require("termfile").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
