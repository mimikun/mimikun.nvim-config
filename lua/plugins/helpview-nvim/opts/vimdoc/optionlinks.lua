-- Configuration for 'optionlink'.
---@type vimdoc.optionlinks
local optionlinks = {
  -- When `false`, optionlinks won't be rendered.
  ---@type boolean

  enable = true,

  -- Default configuration for optionlinks.
  ---@type vimdoc.generic
  default = {
    hl = "Optionlink",
    padding_left = " ",
    padding_right = " ",
  },

  -- Configuration for `'string'` optionlink.
  ---@field [string] vimdoc.generic
}

return optionlinks
