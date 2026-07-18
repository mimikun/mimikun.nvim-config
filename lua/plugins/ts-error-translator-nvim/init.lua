---@type LazySpec
local spec = {
  "dmmulroy/ts-error-translator.nvim",
  --lazy = false,
  event = require("plugins.ts-error-translator-nvim.events"),
  --opts = require("plugins.ts-error-translator-nvim.opts"),
  config = function()
    local opts = require("plugins.ts-error-translator-nvim.opts")
    require("ts-error-translator").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
