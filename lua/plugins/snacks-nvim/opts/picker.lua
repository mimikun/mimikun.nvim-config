-- On trial as the general-purpose picker, to be compared against telescope before settling.
-- Reached through the `<leader>F` keymaps in `keys.lua`.

-- `ui_select = false` is deliberate:
-- telescope is already in the tree (pulled in as a dependency of ascii-nvim, chezmoi-nvim, github-actions-nvim, homeassistant-nvim, iwe-nvim, ...) and telescope-ui-select.nvim already owns `vim.ui.select`.
-- Leaving this at its default would have both plugins assign it, with the winner decided by load order.
-- Keep the trial to picker-vs-picker and leave `vim.ui.select` alone.
---@type snacks.picker.Config
local picker = {
  enabled = true,
  ui_select = false,
}

return picker
