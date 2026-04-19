---@alias Edgy.Pos "bottom"|"top"|"left"|"right"
---@type table<Edgy.Pos, {size:integer | fun():integer, wo?:vim.wo}>
local options = {
  left = {
    size = 30,
  },
  bottom = {
    size = 10,
  },
  right = {
    size = 30,
  },
  top = {
    size = 10,
  },
}

return options
