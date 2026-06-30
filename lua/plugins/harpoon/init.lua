---@type LazySpec
local spec = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  --lazy = false,
  --keys = require("plugins.harpoon.keys"),
  event = require("plugins.harpoon.events"),
  dependencies = require("plugins.harpoon.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.harpoon.opts"),
  config = function()
    local opts = require("plugins.harpoon.opts")
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
