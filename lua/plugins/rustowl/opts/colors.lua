-- Custom colors for different highlight types
---@type rustowl.Colors
local colors = {
  -- Color for lifetime highlights (default: '#00cc00')
  ---@type string
  definitely_live = "#00cc00",

  -- Color for maybe initialized highlights (default: '#00cc00')
  ---@type string
  maybe_initialized = "#00cc00",

  -- Color for immutable borrow highlights (default: '#0000cc')
  ---@type string
  imm_borrow = "#0000cc",

  -- Color for mutable borrow highlights (default: '#cc00cc')
  ---@type string
  mut_borrow = "#cc00cc",

  -- Color for move highlights (default: '#cccc00')
  ---@type string
  move = "#cccc00",

  -- Color for function call highlights (default: '#cccc00')
  ---@type string
  call = "#cccc00",

  ---@type string
  shared_mut = "#cc0000",

  -- Color for outlive error highlights (default: '#cc0000')
  ---@type string
  outlive = "#cc0000",
}

return colors
