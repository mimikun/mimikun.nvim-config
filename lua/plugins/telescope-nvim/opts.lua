local actions = require("telescope.actions")

---@type table
local opts = {
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-h>"] = "which_key",
      },
    },
    winblend = 20,
  },
  pickers = {
    -- TODO: its
  },
  extensions = {
    -- TODO: its
  },
}

return opts
