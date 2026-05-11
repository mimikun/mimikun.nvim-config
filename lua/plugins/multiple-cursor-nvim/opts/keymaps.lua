--@type MultipleCursor.Keymaps
local keymaps = {
  -- Keymap to start or add next match
  ---@type string | false
  start_next = "<C-n>",

  -- Keymap to skip current match
  ---@type string | false
  skip = "<C-x>",

  ---@type string | false
  next_match = "<C-j>",

  ---@type string | false
  prev_match = "<C-k>",

  -- Keymap to select all matches
  ---@type string | false
  select_all = "<C-a>",

  -- Keymap to exit multi-cursor mode
  ---@type string | false
  exit = "<Esc>",
}

return keymaps
