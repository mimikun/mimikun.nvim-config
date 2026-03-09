---@type LazySpec
local spec = {
  "skanehira/denops-docker.vim",
  --lazy = false,
  cmd = require("denops-plugins.denops-docker-vim.cmds"),
  dependencies = require("denops-plugins.denops-docker-vim.dependencies"),
  --opts = require("denops-plugins.denops-docker-vim.opts"),
  --config = function()
  --    INIT
  --end,
  cond = false,
  enabled = false,
}

return spec
