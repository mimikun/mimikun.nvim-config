---@type table
local opts = {
  -- Enables persistent undo history (undofile)
  persistent_undo = true,

  -- Enables default keybindings
  mapping = true,

  -- Step: undo the newest change in the selection
  line_mapping = "gu",

  -- Sweep: undo every selected line's last change
  sweep_mapping = "gU",

  -- Undo for selected characters
  partial_mapping = "gC",

  -- Undo states searched backward per press
  max_history = 100,
}

return opts
