---@type LspsagaConfig.Implement
local implement = {
  -- Enable implementation plugin
  ---@type boolean
  enable = false,

  -- show sign in status column
  ---@type boolean
  sign = true,

  -- Additional languages that support implementing interfaces
  ---@type string[]
  lang = {},

  -- show virtual text at the end of line
  ---@type boolean
  virtual_text = true,

  -- sign priority
  ---@type integer
  priority = 100,
}

return implement
