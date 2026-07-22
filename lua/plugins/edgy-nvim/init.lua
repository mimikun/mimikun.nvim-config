---@type LazySpec
local spec = {
  "folke/edgy.nvim",
  --lazy = false,
  event = require("plugins.edgy-nvim.events"),
  init = function()
    -- views can only be fully collapsed with the global statusline
    vim.opt.laststatus = 3
    -- Default splitting will cause your main splits to jump when opening an edgebar.
    -- To prevent this, set `splitkeep` to either `screen` or `topline`.
    vim.opt.splitkeep = "screen"
  end,
  --opts = require("plugins.edgy-nvim.opts"),
  config = function()
    local opts = require("plugins.edgy-nvim.opts")
    require("edgy").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
