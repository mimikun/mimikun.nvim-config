---@type LazySpec
local spec = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  cmd = require("plugins.nvim-treesitter.cmds"),
  config = function()
    local nvim_treesitter = require("nvim-treesitter")

    -- Setup
    nvim_treesitter.setup(require("plugins.nvim-treesitter.opts"))

    -- Install: wait 5 minutes
    nvim_treesitter
      .install(require("plugins.nvim-treesitter.install.languages"), require("plugins.nvim-treesitter.install.options"))
      :wait(300000)
  end,
  --cond = false,
  --enabled = false,
}

return spec
