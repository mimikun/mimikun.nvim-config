---@type LazySpec
local spec = {
  "willothy/wezterm.nvim",
  --lazy = false,
  --url = "",
  --dev = false,
  cmd = require("plugins.wezterm-nvim.cmds"),
  keys = require("plugins.wezterm-nvim.keys"),
  event = require("plugins.wezterm-nvim.events"),
  --opts = require("plugins.wezterm-nvim.opts"),
  config = function()
    local opts = require("plugins.wezterm-nvim.opts")
    require("wezterm").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
