---@type LazySpec
local spec = {
  --lazy = false,
  "MaximilianLloyd/ascii.nvim",
  event = require("plugins.ascii-nvim.events"),
  dependencies = require("plugins.ascii-nvim.dependencies"),
  config = function()
    require("telescope").load_extension("ascii")
  end,
  --cond = false,
  --enabled = false,
}

return spec
