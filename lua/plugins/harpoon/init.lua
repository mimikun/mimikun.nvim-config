---@type LazySpec
local spec = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  --lazy = false,
  --ft = require("plugins.harpoon.ft"),
  --cmd = require("plugins.harpoon.cmds"),
  --keys = require("plugins.harpoon.keys"),
  --event = require("plugins.harpoon.events"),
  dependencies = require("plugins.harpoon.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.harpoon.opts"),
  --config = function()
  --  local opts = require("plugins.harpoon.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
