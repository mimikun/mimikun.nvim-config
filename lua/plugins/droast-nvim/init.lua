---@type LazySpec
local spec = {
  "immanuwell/droast.nvim",
  --lazy = false,
  ft = require("plugins.droast-nvim.ft"),
  cmd = require("plugins.droast-nvim.cmds"),
  event = require("plugins.droast-nvim.events"),
  --opts = require("plugins.droast-nvim.opts"),
  config = function()
    local opts = require("plugins.droast-nvim.opts")
    require("droast").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
