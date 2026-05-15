---@type LazySpec
local spec = {
  "nvimtools/hydra.nvim",
  --lazy = false,
  --keys = require("plugins.hydra-nvim.keys"),
  event = require("plugins.hydra-nvim.events"),
  --dependencies = require("plugins.hydra-nvim.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.hydra-nvim.opts"),
  --config = function()
  --  local opts = require("plugins.hydra-nvim.opts")
  --end,
  --cond = false,
  --enabled = false,
}

return spec
