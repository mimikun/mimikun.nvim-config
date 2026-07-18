---@type LazySpec
local spec = {
  "mrcjkb/rustaceanvim",
  -- To avoid being surprised by breaking changes,
  -- I recommend you set a version range
  version = "^9",
  -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
  -- No need for lazy.nvim to lazy-load it.
  lazy = false,
  --ft = require("plugins.rustaceanvim.ft"),
  --cmd = require("plugins.rustaceanvim.cmds"),
  --keys = require("plugins.rustaceanvim.keys"),
  --event = require("plugins.rustaceanvim.events"),
  --dependencies = require("plugins.rustaceanvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.rustaceanvim.opts"),
  --config = function()
  --  local opts = require("plugins.rustaceanvim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
