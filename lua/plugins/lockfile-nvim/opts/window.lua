---@type lockfile.WindowConfig
local window = {
  -- how to present the report
  ---@type string | "float" | "split"
  style = "float",

  -- fraction of columns, or absolute count
  -- float width (cols, or fraction <=1)
  ---@type number
  width = 0.8,

  -- float height (rows, or fraction <=1)
  ---@type number
  height = 0.8,

  -- float border style
  ---@type string
  border = "rounded",
}

return window
