---@type crates.UserPopupKeyConfig
local keys = {
  ---@type string[]
  hide = {
    "q",
    "<esc>",
  },

  ---@type string[]
  open_url = {
    "<cr>",
  },

  ---@type string[]
  select = {
    "<cr>",
  },

  ---@type string[]
  select_alt = {
    "s",
  },

  ---@type string[]
  toggle_feature = {
    "<cr>",
  },

  ---@type string[]
  copy_value = {
    "yy",
  },

  ---@type string[]
  goto_item = {
    "gd",
    "K",
    "<C-LeftMouse>",
  },

  ---@type string[]
  jump_forward = {
    "<c-i>",
  },

  ---@type string[]
  jump_back = {
    "<c-o>",
    "<C-RightMouse>",
  },
}

return keys
