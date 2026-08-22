-- Configuration for {arguments}.
---@type vimdoc.arguments
local arguments = {
  -- When `false`, arguments don't get rendered.
  ---@type boolean
  enable = true,

  -- Default configuration for arguments.
  ---@type vimdoc.generic
  default = {
    hl = "Argument",
    padding_left = " ",
    padding_right = " ",
  },

  -- Configuration for `{string}`.
  ---@field [string] vimdoc.generic

  ---@field corner_left? string
  ---@field padding_left? string

  ---@field icon? string

  ---@field padding_right? string
  ---@field corner_right? string

  -- Primary highlight group.
  -- Used by other `*_hl` option(s) when a value isn't given.
  ---@field hl? string

  ---@field corner_left_hl? string
  ---@field padding_left_hl? string

  ---@field icon_hl? string

  ---@field padding_right_hl? string
  ---@field corner_right_hl? string
}

return arguments
