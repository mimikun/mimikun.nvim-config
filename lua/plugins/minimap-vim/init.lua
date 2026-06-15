---@type LazySpec
local spec = {
  "wfxr/minimap.vim",
  --lazy = false,
  cmd = require("plugins.minimap-vim.cmds"),
  event = require("plugins.minimap-vim.events"),
  --dependencies = require("plugins.minimap-vim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.minimap-vim.opts"),
  --config = function()
  --  local opts = require("plugins.minimap-vim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
