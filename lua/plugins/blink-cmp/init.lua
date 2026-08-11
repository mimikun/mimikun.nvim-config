---@type LazySpec
local spec = {
  "saghen/blink.cmp",
  --lazy = false,
  -- NOTE: Do not set `version`. v2 lives on the `main` branch only, so `version = "*"` would pin this back to v1.
  build = function()
    -- download prebuilt binaries from github releases
    --require("blink.cmp").download():pwait(60000)
    -- build from source
    require("blink.cmp").build():pwait(60000)
  end,
  --url = "",
  --name = "",
  --dev = false,
  --dir = "",
  --branch = "",
  --tag = "",
  --version = "",
  --commit = "",
  --main = "",
  --pin = false,
  --submodules = false,
  --module = false,
  --optional = false,
  cmd = require("plugins.blink-cmp.cmds"),
  --keys = require("plugins.blink-cmp.keys"),
  event = require("plugins.blink-cmp.events"),
  dependencies = require("plugins.blink-cmp.dependencies"),
  --opts = require("plugins.blink-cmp.opts"),
  config = function()
    local opts = require("plugins.blink-cmp.opts")
    require("blink.cmp").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
