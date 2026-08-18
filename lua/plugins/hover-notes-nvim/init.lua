---@type LazySpec
local spec = {
  "lolpie244/hover-notes.nvim",
  --lazy = false,
  cmd = require("plugins.hover-notes-nvim.cmds"),
  event = require("plugins.hover-notes-nvim.events"),
  --opts = require("plugins.hover-notes-nvim.opts"),
  config = function()
    local opts = require("plugins.hover-notes-nvim.opts")
    require("hover-notes").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
