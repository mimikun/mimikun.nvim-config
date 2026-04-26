---@type snacks.input.Config
local input = {
  enabled = true,
  ---@type string
  icon = " ",
  icon_hl = "SnacksInputIcon",
  ---@type snacks.input.Pos
  icon_pos = "left",
  ---@type snacks.input.Pos
  prompt_pos = "title",
  ---@type snacks.win.Config|{}
  win = {
    style = "input",
  },
  expand = true,
}

return input
