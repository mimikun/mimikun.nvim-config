-- Configuration for <Keycodes>.
---@type vimdoc.keycodes
local keycodes = {
  -- When `false`, keycodes aren't rendered.
  ---@type boolean
  enable = true,

  -- Default configuration for keycodes.
  ---@type vimdoc.generic
  default = {
    hl = "Keycode",

    padding_left = " ",
    padding_right = " ",
  },

  -- Configuration for `<string>`.
  ---@field [string] vimdoc.generic
}

return keycodes
