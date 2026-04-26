---@type LazySpec
local spec = {
  "saghen/blink.pairs",
  --lazy = false,
  -- NOTE: recommended:only required with prebuilt binaries
  version = "*",
  -- build from source,
  --build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  --build = 'nix run .#build-plugin',
  event = require("plugins.blink-pairs.events"),
  dependencies = require("plugins.blink-pairs.dependencies"),
  opts = require("plugins.blink-pairs.opts"),
  --cond = false,
  --enabled = false,
}

return spec
