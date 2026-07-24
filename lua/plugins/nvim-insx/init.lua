---@type LazySpec
local spec = {
  "hrsh7th/nvim-insx",
  --lazy = false,
  --keys = require("plugins.nvim-insx.keys"),
  event = require("plugins.nvim-insx.events"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.nvim-insx.opts"),
  --config = function()
  --  local opts = require("plugins.nvim-insx.opts")
  --end,
  cond = false,
  enabled = false,
}

return spec
