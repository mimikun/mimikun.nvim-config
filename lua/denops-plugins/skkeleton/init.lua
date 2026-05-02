---@type LazySpec
local spec = {
  "vim-skk/skkeleton",
  --lazy = false,
  --ft = require("denops-plugins.skkeleton.ft"),
  --cmd = require("denops-plugins.skkeleton.cmds"),
  --keys = require("denops-plugins.skkeleton.keys"),
  --event = require("denops-plugins.skkeleton.events"),
  dependencies = require("denops-plugins.skkeleton.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("denops-plugins.skkeleton.opts"),
  --config = function()
  --    INIT
  --end,
  cond = false,
  enabled = false,
}

return spec
