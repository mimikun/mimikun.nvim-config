---@type LazySpec
local spec = {
  "chrisgrieser/nvim-lsp-endhints",
  --lazy = false,
  event = require("plugins.nvim-lsp-endhints.events"),
  --opts = require("plugins.nvim-lsp-endhints.opts"),
  config = function()
    local opts = require("plugins.nvim-lsp-endhints.opts")
    require("lsp-endhints").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
