---@type LazySpec
local spec = {
  "saghen/blink.cmp",
  --lazy = false,
  -- NOTE: Do not set `version`. v2 lives on the `main` branch only,
  -- so `version = "*"` would pin this back to v1.
  build = function()
    -- download prebuilt binaries from github releases
    --require("blink.cmp").download():pwait(60000)
    -- build from source
    require("blink.cmp").build():pwait(60000)
  end,
  event = require("plugins.blink-cmp.events"),
  dependencies = require("plugins.blink-cmp.dependencies"),
  opts = require("plugins.blink-cmp.opts"),
  --cond = false,
  --enabled = false,
}

return spec
