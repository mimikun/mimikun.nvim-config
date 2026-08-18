---@type LazySpec
local spec = {
  "kevinhwang91/nvim-ufo",
  --lazy = false,
  cmd = require("plugins.nvim-ufo.cmds"),
  --keys = require("plugins.nvim-ufo.keys"),
  event = require("plugins.nvim-ufo.events"),
  dependencies = require("plugins.nvim-ufo.dependencies"),
  init = function()
    -- '0' is not bad
    vim.opt.foldcolumn = "1"

    -- Using ufo provider need a large value, feel free to decrease the value
    vim.opt.foldlevel = 99

    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
  end,
  --opts = require("plugins.nvim-ufo.opts"),
  config = function()
    local opts = require("plugins.nvim-ufo.opts")
    require("ufo").setup(opts)

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
  cond = false,
  enabled = false,
}

return spec
