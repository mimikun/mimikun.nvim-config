---@type LazySpec
local spec = {
  "MeanderingProgrammer/render-markdown.nvim",
  --lazy = false,
  ft = require("plugins.render-markdown-nvim.ft"),
  cmd = require("plugins.render-markdown-nvim.cmds"),
  event = require("plugins.render-markdown-nvim.events"),
  dependencies = require("plugins.render-markdown-nvim.dependencies"),
  --opts = require("plugins.render-markdown-nvim.opts"),
  config = function()
    local opts = require("plugins.render-markdown-nvim.opts")
    require("render-markdown").setup(opts)

    vim.treesitter.language.register("markdown", "vimwiki")
  end,
  --cond = false,
  --enabled = false,
}

return spec
