---@type LazySpec
local spec = {
  "dmtrKovalenko/fff.nvim",
  -- the plugin lazy-initialises itself
  lazy = false,
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require("fff.download").download_or_build_binary()
    -- for nixos:
    --return "nix run .#release"
  end,
  cmd = require("plugins.fff-nvim.cmds"),
  keys = require("plugins.fff-nvim.keys"),
  event = require("plugins.fff-nvim.events"),
  --opts = require("plugins.fff-nvim.opts"),
  config = function()
    local opts = require("plugins.fff-nvim.opts")
    require("fff").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
