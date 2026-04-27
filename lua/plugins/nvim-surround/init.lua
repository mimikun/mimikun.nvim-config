---@type LazySpec
local spec = {
  "kylechui/nvim-surround",
  --lazy = false,
  -- Use for stability; omit to use `main` branch for the latest features
  version = "^4.0.0",
  --ft = require("plugins.nvim-surround.ft"),
  --cmd = require("plugins.nvim-surround.cmds"),
  --keys = require("plugins.nvim-surround.keys"),
  event = require("plugins.nvim-surround.events"),
  --dependencies = require("plugins.nvim-surround.dependencies"),
  init = function()
    -- Boolean value determining if the default keymaps are set.
    vim.g.nvim_surround_no_mappings = false

    -- Boolean value determining if the default normal mode keymaps are set.
    vim.g.nvim_surround_no_normal_mappings = false

    -- Boolean value determining if the default visual mode keymaps are set.
    vim.g.nvim_surround_no_visual_mappings = false

    -- Boolean value determining if the default insert mode keymaps are set.
    vim.g.nvim_surround_no_insert_mappings = false
  end,
  --opts = require("plugins.nvim-surround.opts"),
  config = function()
    local opts = require("plugins.nvim-surround.opts")
    require("nvim-surround").setup(opts)
    -- NOTE: While `ysabB` is a valid surround action, `ysarB` is not, since `ar` is not a valid Vim motion.
    -- This can be side-stepped by creating the following operator-mode maps:
    --vim.keymap.set("o", "ir", "i[")
    --vim.keymap.set("o", "ar", "a[")
    --vim.keymap.set("o", "ia", "i<")
    --vim.keymap.set("o", "aa", "a<")
  end,
  --cond = false,
  --enabled = false,
}

return spec
