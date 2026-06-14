---@type LazySpec
local spec = {
  "kopecmaciej/vi-sql.nvim",
  --lazy = false,
  cmd = require("plugins.vi-sql-nvim.cmds"),
  keys = require("plugins.vi-sql-nvim.keys"),
  event = require("plugins.vi-sql-nvim.events"),
  --opts = require("plugins.vi-sql-nvim.opts"),
  config = function()
    local opts = require("plugins.vi-sql-nvim.opts")
    require("vi-sql").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
