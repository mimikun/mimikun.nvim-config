---@type table
local opts = {
  -- When both representations fit within `size_width`,
  -- prefer human-readable sizes (`1K`, `12M`) over raw byte counts (`1024`, `12582912`).
  ---@type boolean
  size_prefer_units = true,

  -- Width of the size column
  ---@type number
  size_width = 6,

  -- Modification time format
  ---@type string
  mtime_format = "%Y-%m-%d %H:%M:%S",

  -- Maximum length of the owner's text
  ---@type number
  owner_width = 10,
}

return opts
