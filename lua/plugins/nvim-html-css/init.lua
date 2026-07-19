---@type LazySpec
local spec = {
  "Jezda1337/nvim-html-css",
  --lazy = false,
  --ft = require("plugins.nvim-html-css.ft"),
  --cmd = require("plugins.nvim-html-css.cmds"),
  --keys = require("plugins.nvim-html-css.keys"),
  event = require("plugins.nvim-html-css.events"),
  dependencies = require("plugins.nvim-html-css.dependencies"),
  --opts = require("plugins.nvim-html-css.opts"),
  config = function()
    local opts = require("plugins.nvim-html-css.opts")
  end,
  cond = false,
  enabled = false,
}

return spec
