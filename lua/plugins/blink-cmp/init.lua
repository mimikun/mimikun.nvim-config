---@type LazySpec
local spec = {
  "saghen/blink.cmp",
  --lazy = false,
  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source
  --build = 'cargo build --release',
  -- If you use nix, you can build from source with:
  --build = 'nix run .#build-plugin',
  --ft = require("plugins.blink-cmp.ft"),
  --cmd = require("plugins.blink-cmp.cmds"),
  --keys = require("plugins.blink-cmp.keys"),
  event = require("plugins.blink-cmp.events"),
  dependencies = require("plugins.blink-cmp.dependencies"),
  --init = function()
  --    INIT
  --end,
  opts = require("plugins.blink-cmp.opts"),
  opts_extend = { "sources.default" },
  --config = function()
  --    INIT
  --end,
  --cond = false,
  --enabled = false,
}

return spec
