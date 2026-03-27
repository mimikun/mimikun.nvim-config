---@type LazySpec
local spec = {
  "RRethy/vim-illuminate",
  --lazy = false,
  cmd = require("plugins.vim-illuminate.cmds"),
  keys = require("plugins.vim-illuminate.keys"),
  event = require("plugins.vim-illuminate.events"),
  config = function()
    require("illuminate").configure(require("plugins.vim-illuminate.opts"))
  end,
  --cond = false,
  --enabled = false,
}

return spec
