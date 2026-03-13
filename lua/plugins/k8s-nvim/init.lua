---@type LazySpec
local spec = {
  "skanehira/k8s.nvim",
  --lazy = false,
  cmd = require("plugins.k8s-nvim.cmds"),
  event = require("plugins.k8s-nvim.events"),
  dependencies = require("plugins.k8s-nvim.dependencies"),
  opts = require("plugins.k8s-nvim.opts"),
  --cond = false,
  --enabled = false,
}

return spec
