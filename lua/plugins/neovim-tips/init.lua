---@type LazySpec
local spec = {
  "saxon1964/neovim-tips",
  -- Load only when keybinds are triggered
  lazy = true,
  -- Only update on tagged releases
  --version = "*",
  cmd = require("plugins.neovim-tips.cmds"),
  keys = require("plugins.neovim-tips.keys"),
  event = require("plugins.neovim-tips.events"),
  dependencies = require("plugins.neovim-tips.dependencies"),
  --opts = require("plugins.neovim-tips.opts"),
  config = function()
    local opts = require("plugins.neovim-tips.opts")
    require("neovim_tips").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
