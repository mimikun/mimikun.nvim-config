---@type LazySpec
local spec = {
  "delphinus/md-render.nvim",
  --lazy = false,
  --version = "*",
  ft = require("plugins.md-render-nvim.ft"),
  cmd = require("plugins.md-render-nvim.cmds"),
  keys = require("plugins.md-render-nvim.keys"),
  event = require("plugins.md-render-nvim.events"),
  dependencies = require("plugins.md-render-nvim.dependencies"),
  config = function()
    --local opts_image = require("plugins.md-render-nvim.opts.image")
    --require("md-render.image").setup(opts_image)

    --local opts_text_size = require("plugins.md-render-nvim.opts.text_size")
    --require("md-render.text_size").setup(opts_text_size)
  end,
  --cond = false,
  --enabled = false,
}

return spec
