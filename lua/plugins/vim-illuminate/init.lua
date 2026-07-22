---@type LazySpec
local spec = {
  "RRethy/vim-illuminate",
  --lazy = false,
  cmd = require("plugins.vim-illuminate.cmds"),
  keys = require("plugins.vim-illuminate.keys"),
  event = require("plugins.vim-illuminate.events"),
  --opts = require("plugins.vim-illuminate.opts"),
  config = function()
    local opts = require("plugins.vim-illuminate.opts")
    require("illuminate").configure(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
