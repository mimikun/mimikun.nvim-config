---@type LazySpec
local spec = {
  "lewis6991/hover.nvim",
  --lazy = false,
  keys = require("plugins.hover-nvim.keys"),
  --event = require("plugins.hover-nvim.events"),
  --opts = require("plugins.hover-nvim.opts"),
  config = function()
    local opts = require("plugins.hover-nvim.opts")
    local hover = require("hover")

    hover.config(opts)

    vim.keymap.set("n", "<MouseMove>", function()
      hover.mouse()
    end, {
      desc = "hover.nvim (mouse)",
    })

    vim.o.mousemoveevent = true
  end,
  --cond = false,
  --enabled = false,
}

return spec
