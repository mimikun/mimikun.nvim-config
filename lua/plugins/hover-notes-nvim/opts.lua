---@type table
local opts = {
  -- the root directory where all notes are stored
  notesDir = vim.fn.stdpath("data") .. "/hover-notes",

  -- the default note category
  defaultCategory = {
    name = "Default",
    format = "{text}",
  },

  -- style of the float window
  ui = {
    float = {
      style = "minimal",
      border = "rounded",
    },
  },
}

return opts
