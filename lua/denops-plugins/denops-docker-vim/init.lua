-- denops is gated on host/OS; see lua/config/denops.lua for the allowlist.
local denops_enabled = require("config.denops")

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
  cond = denops_enabled,
  enabled = denops_enabled,
}

return spec
