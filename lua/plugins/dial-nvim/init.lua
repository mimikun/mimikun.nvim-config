---@type LazySpec
local spec = {
  "monaqa/dial.nvim",
  --lazy = false,
  keys = require("plugins.dial-nvim.keys"),
  event = require("plugins.dial-nvim.events"),
  --opts = require("plugins.dial-nvim.opts"),
  config = function()
    local opts = require("plugins.dial-nvim.opts")
    require("dial.config").augends:register_group(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
