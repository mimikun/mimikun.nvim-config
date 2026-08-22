-- Configuration for |taglink|.
---@type vimdoc.taglinks
local taglinks = {
  -- When `false`, taglinks won't be rendered.
  ---@field enable? boolean
  enable = true,

  -- Default configuration for taglinks.
  ---@type vimdoc.generic
  default = {
    hl = "Taglink",

    padding_left = " ",
    padding_right = " ",
  },

  -- Configuration for `|string|` taglink.
  ---@field [string] vimdoc.generic
}

return taglinks
