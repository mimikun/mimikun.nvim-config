---@type LazySpec
local spec = {
  "ryanmab/onoma.nvim",
  --lazy = false,
  -- Required when using prebuilt binaries
  version = "*",
  -- Otherwise, you can build from source
  --build = "cargo --config ./bridge/.cargo/config.toml build --release --manifest-path ./bridge/Cargo.toml",
  keys = require("plugins.onoma-nvim.keys"),
  event = require("plugins.onoma-nvim.events"),
  dependencies = require("plugins.onoma-nvim.dependencies"),
  --opts = require("plugins.onoma-nvim.opts"),
  config = function()
    local opts = require("plugins.onoma-nvim.opts")
    require("onoma").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
