---@type LazySpec
local spec = {
  url = "https://tangled.org/vale.rocks/weborigami-nvim",
  --lazy = false,
  submodules = false,
  event = require("plugins.weborigami-nvim.events"),
  --opts = require("plugins.weborigami-nvim.opts"),
  config = function()
    local opts = require("plugins.weborigami-nvim.opts")
    require("weborigami-nvim").setup(opts)
  end,
  --cond = false,
  --enabled = false,
}

return spec
