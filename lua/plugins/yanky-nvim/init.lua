---@type LazySpec
local spec = {
  "gbprod/yanky.nvim",
  --lazy = false,
  cmd = require("plugins.yanky-nvim.cmds"),
  keys = require("plugins.yanky-nvim.keys"),
  event = require("plugins.yanky-nvim.events"),
  dependencies = require("plugins.yanky-nvim.dependencies"),
  --opts = require("plugins.yanky-nvim.opts"),
  config = function()
    local opts = require("plugins.yanky-nvim.opts")
    require("yanky").setup(opts)
    --require("telescope").load_extension("yank_history")
  end,
  --cond = false,
  --enabled = false,
}

return spec
