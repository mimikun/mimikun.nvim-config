-- Configuration for
---@type vimdoc.inline_codes
local inline_codes = {
  enable = true,

  hl = "Palette5",

  padding_left = " ",
  padding_right = " ",
}

return inline_codes
--- Configuration for inline codes.
---@see vimdoc.generic
---
---@class vimdoc.inline_codes
---
--- When `false`, inline codes aren't rendered.
---@field enable? boolean
---
---@field corner_left? string
---@field padding_left? string
---
---@field icon? string
---
---@field padding_right? string
---@field corner_right? string
---
---@field hl? string
---
---@field corner_left_hl? string
---@field padding_left_hl? string
---
---@field icon_hl? string
---
---@field padding_right_hl? string
---@field corner_right_hl? string
