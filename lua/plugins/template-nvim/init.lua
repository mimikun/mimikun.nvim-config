---@type LazySpec
local spec = {
  "nvimdev/template.nvim",
  --lazy = false,
  cmd = require("plugins.template-nvim.cmds"),
  keys = require("plugins.template-nvim.keys"),
  event = require("plugins.template-nvim.events"),
  dependencies = require("plugins.template-nvim.dependencies"),
  --opts = require("plugins.template-nvim.opts"),
  config = function()
    local opts = require("plugins.template-nvim.opts")
    require("template").setup(opts)

    --require("telescope").load_extension("find_template")
  end,
  --cond = false,
  --enabled = false,
}

return spec
