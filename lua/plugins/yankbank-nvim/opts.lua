---@type table
local opts = {
  ---@type numbers integer number of entries to show in popup
  max_entries = 10,
  ---@type string  string separator to show between table entries
  sep = "-----",
  ---@type string | "prefix" | "jump" string defining jump behavior
  num_behavior = "jump",
  ---@type boolean
  focus_gain_poll = true,
  ---@type string | nil | "sqlite"  string defining persistence type
  persist_type = "sqlite",
  ---@type table table containing keymap overrides
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
  ---@type table table container for register overrides
  registers = {
    ---@type string | "+" default register to yank from popup to
    yank_register = "+",
  },
  ---@type string | nil optional string to be used for keybind prefix for pasting by index number
  bind_indices = "<leader>p",
  ---@type table table containing all pickers
  pickers = {
    ---@type boolean
    snacks = true,
  },
  ---@type string | nil string defining database file path for use with sqlite persistence | plugin install directory
  db_path = nil,
}

return opts
