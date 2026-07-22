---@type LazySpec
local spec = {
  "taigrr/glaze.nvim",
  --lazy = false,
  cmd = require("plugins.glaze-nvim.cmds"),
  event = require("plugins.glaze-nvim.events"),
  --opts = require("plugins.glaze-nvim.opts"),
  config = function()
    local opts = require("plugins.glaze-nvim.opts")
    local glaze = require("glaze")

    glaze.setup(opts)
    -- Register binaries
    --glaze.register("freeze", "github.com/charmbracelet/freeze")
    --glaze.register("glow", "github.com/charmbracelet/glow")
    --glaze.register("gum", "github.com/charmbracelet/gum")
  end,
  --cond = false,
  --enabled = false,
}

return spec
