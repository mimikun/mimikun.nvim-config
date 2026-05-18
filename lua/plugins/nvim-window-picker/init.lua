---@type LazySpec
local spec = {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  --lazy = false,
  --version = "2.*",
  event = require("plugins.nvim-window-picker.events"),
  --opts = require("plugins.nvim-window-picker.opts"),
  config = function()
    local opts = require("plugins.nvim-window-picker.opts")
    require("window-picker").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
