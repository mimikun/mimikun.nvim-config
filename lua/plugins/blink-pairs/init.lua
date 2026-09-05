---@type LazySpec
local spec = {
  "saghen/blink.pairs",
  --lazy = false,
  -- NOTE: Do not set `version`. `blink.lib` publishes no tags, so it always
  -- tracks `main`. Pinning this to the latest tag strands it on an older
  -- `blink.lib` config API and breaks setup at startup.
  build = function()
    -- download prebuilt binaries from github releases, must be on a versioned release
    --require("blink.pairs").download():pwait(60000)
    -- build from source
    require("blink.pairs").build():pwait(60000)
  end,
  event = require("plugins.blink-pairs.events"),
  dependencies = require("plugins.blink-pairs.dependencies"),
  opts = require("plugins.blink-pairs.opts"),
  --cond = false,
  --enabled = false,
}

return spec
