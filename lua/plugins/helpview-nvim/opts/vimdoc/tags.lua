-- Configuration for *tag*.
---@type vimdoc.tags
local tags = {
  -- When `false`, tags won't be rendered.
  ---@type boolean
  enable = true,

  -- Default configuration for tags.
  ---@type vimdoc.generic
  default = {
    hl = "Tag",

    padding_left = " ",
    padding_right = " ",
  },

  -- Configuration for `*string*` tag.
  ---@type vimdoc.generic
  ["%.txt$"] = {
    hl = "Palette3",
  },

  -- Configuration for `*string*` tag.
  ---@field [string] vimdoc.generic
}

return tags
