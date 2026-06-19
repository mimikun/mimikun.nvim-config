---@type LazySpec
local spec = {
  "saghen/blink.indent",
  --lazy = false,
  keys = require("plugins.blink-indent.keys"),
  event = require("plugins.blink-indent.events"),
  init = function()
    ---@type boolean
    vim.g.indent_guide = false
  end,
  --opts = require("plugins.blink-indent.opts"),
  config = function()
    local opts = require("plugins.blink-indent.opts")
    require("blink.indent").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
