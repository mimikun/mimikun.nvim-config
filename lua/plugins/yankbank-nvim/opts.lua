---@type table
local opts = {
  -- integer number of entries to show in popup
  ---@type numbers
  max_entries = 10,

  -- string separator to show between table entries
  ---@type string
  sep = "-----",

  -- string defining jump behavior
  ---@type string | "prefix" | "jump"
  num_behavior = "jump",

  ---@type boolean
  focus_gain_poll = true,

  -- string defining persistence type
  ---@type string | nil | "sqlite"
  persist_type = "sqlite",

  -- table containing keymap overrides
  ---@type table
  keymaps = {
    ---@type string
    navigation_next = "j",

    ---@type string
    navigation_prev = "k",

    ---@type string
    paste = "<CR>",

    ---@type string
    paste_back = "P",

    ---@type string
    yank = "yy",

    ---@type table<string>
    close = {
      "<Esc>",
      "<C-c>",
      "q",
    },
  },

  -- table container for register overrides
  ---@type table
  registers = {
    -- default register to yank from popup to
    ---@type string | "+"
    yank_register = "+",
  },

  -- optional string to be used for keybind prefix for pasting by index number
  ---@type string | nil
  bind_indices = "<leader>p",

  -- table containing all pickers
  ---@type table
  pickers = {
    ---@type boolean
    snacks = true,
  },

  -- string defining database file path for use with sqlite persistence | plugin install directory
  ---@type string | nil
  db_path = nil,
}

return opts
