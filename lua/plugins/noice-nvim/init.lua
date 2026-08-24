---@type LazySpec
local spec = {
  "folke/noice.nvim",
  --lazy = false,
  cmd = require("plugins.noice-nvim.cmds"),
  --keys = require("plugins.noice-nvim.keys"),
  event = require("plugins.noice-nvim.events"),
  dependencies = require("plugins.noice-nvim.dependencies"),
  --opts = require("plugins.noice-nvim.opts"),
  config = function()
    local opts = require("plugins.noice-nvim.opts")
    require("noice").setup(opts)

    --require("telescope").load_extension("noice")
  end,
  --cond = false,
  --enabled = false,
}

return spec
