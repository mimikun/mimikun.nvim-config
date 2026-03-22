---@type LazySpec
local spec = {
  "Nako0/devglobe-extension",
  --lazy = false,
  build = "cd devglobe-core && npm install && npm run build",
  --build = require("plugins.devglobe-extension-nvim.builds"),
  cmd = require("plugins.devglobe-extension-nvim.cmds"),
  event = require("plugins.devglobe-extension-nvim.events"),
  config = function()
    vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/devglobe-extension/neovim-plugin")
    vim.cmd("runtime plugin/devglobe.lua")
    require("devglobe").setup()
  end,
  --cond = false,
  --enabled = false,
}

return spec
