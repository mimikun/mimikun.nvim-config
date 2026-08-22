-- Configuration for Note.
---@type vimdoc.notes
local notes = {
  -- When `false`, notes won't be rendered.
  ---@type boolean
  enable = true,

  -- Default configuration for notes.
  ---@type vimdoc.generic
  default = {
    hl = "Palette5Inv",
    padding_left = " ",
    padding_right = " ",
  },

  -- Configuration for `string` note.
  ---@field [string] vimdoc.generic
  ["[dD]eprecated"] = {
    hl = "Palette1Inv",
  },

  ["[wW]arning"] = {
    hl = "Palette3Inv",
  },
}

return notes
