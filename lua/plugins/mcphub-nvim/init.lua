---@type LazySpec
local spec = {
  "ravitemer/mcphub.nvim",
  --lazy = false,
  build = require("plugins.mcphub-nvim.builds"),
  cmd = require("plugins.mcphub-nvim.cmds"),
  event = require("plugins.mcphub-nvim.events"),
  dependencies = require("plugins.mcphub-nvim.dependencies"),
  --opts = require("plugins.mcphub-nvim.opts"),
  config = function()
    local opts = require("plugins.mcphub-nvim.opts")
    require("mcphub").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
