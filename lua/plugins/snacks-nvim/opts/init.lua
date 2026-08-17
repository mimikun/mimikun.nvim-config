-- NOTE: snacks.nvim modules are opt-in. Modules that overlap with plugins
-- already in this config are left disabled on purpose:
--   dashboard -> alpha-nvim,  notifier -> nvim-notify,
--   indent    -> indent-blankline-nvim / blink-indent,
--   statuscolumn -> statuscol-nvim,  explorer/picker -> oil-nvim / nvim-deck,
--   image     -> image-nvim,  dim -> twilight-nvim,  words -> vim-illuminate,
--   scroll    -> smear-cursor-nvim
-- Modules without a `setup` requirement (lazygit, gitbrowse, scratch, rename,
-- bufdelete, terminal, zen, ...) work on demand via the keymaps in keys.lua.

---@type table
local opts = {
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true },
  scope = { enabled = true },
}

return opts
