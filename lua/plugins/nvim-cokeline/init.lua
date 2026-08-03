---@type LazySpec
local spec = {
  "willothy/nvim-cokeline",
  --lazy = false,
  keys = require("plugins.nvim-cokeline.keys"),
  event = require("plugins.nvim-cokeline.events"),
  dependencies = require("plugins.nvim-cokeline.dependencies"),
  init = function()
    -- cokeline reads hex gui values, so truecolor is a hard requirement
    vim.opt.termguicolors = true
    -- cokeline sets this itself on load, but keep the requirement visible here
    vim.opt.showtabline = 2
  end,
  --opts = require("plugins.nvim-cokeline.opts"),
  config = function()
    local opts = require("plugins.nvim-cokeline.opts")
    require("cokeline").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
