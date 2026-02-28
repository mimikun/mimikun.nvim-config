---@type LazySpec
local spec = {
  "taigrr/glaze.nvim",
  --lazy = false,
  cmd = require("plugins.glaze-nvim.cmds"),
  --event = "VeryLazy",
  --opts = require("plugins.glaze-nvim.opts"),
  config = function()
    local glaze = require("glaze")

    glaze.setup(require("plugins.glaze-nvim.opts"))
    -- Register binaries
    --glaze.register("freeze", "github.com/charmbracelet/freeze")
    --glaze.register("glow", "github.com/charmbracelet/glow")
    --glaze.register("gum", "github.com/charmbracelet/gum")
  end,
  --cond = false,
  --enabled = false,
}

return spec
