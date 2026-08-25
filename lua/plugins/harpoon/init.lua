---@type LazySpec
local spec = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  --lazy = false,
  --keys = require("plugins.harpoon.keys"),
  event = require("plugins.harpoon.events"),
  dependencies = require("plugins.harpoon.dependencies"),
  --opts = require("plugins.harpoon.opts"),
  config = function()
    local opts = require("plugins.harpoon.opts")
    local harpoon = require("harpoon")

    harpoon:setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
