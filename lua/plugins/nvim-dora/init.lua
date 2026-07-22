---@type LazySpec
local spec = {
  "beardedsakimonkey/nvim-dora",
  --lazy = false,
  cmd = require("plugins.nvim-dora.cmds"),
  keys = require("plugins.nvim-dora.keys"),
  event = require("plugins.nvim-dora.events"),
  dependencies = require("plugins.nvim-dora.dependencies"),
  init = function()
    vim.g.dora_disable_auto_open = true
  end,
  --opts = require("plugins.nvim-dora.opts"),
  config = function()
    local opts = require("plugins.nvim-dora.opts")
    require("dora").configure(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
