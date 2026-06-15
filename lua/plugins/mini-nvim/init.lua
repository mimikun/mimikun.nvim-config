local version
-- Stable branch
version = "*"
-- Main branch
version = false

---@type LazySpec
local spec = {
  "nvim-mini/mini.nvim",
  --lazy = false,
  version = version,
  --ft = require("plugins.mini-nvim.ft"),
  --cmd = require("plugins.mini-nvim.cmds"),
  --keys = require("plugins.mini-nvim.keys"),
  --event = require("plugins.mini-nvim.events"),
  --dependencies = require("plugins.mini-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.mini-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.mini-nvim.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
