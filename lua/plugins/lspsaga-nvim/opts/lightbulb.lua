---@type LspsagaConfig.Lightbulb
local lightbulb = {
  -- enable lightbulb
  ---@type boolean
  enable = true,

  -- show sign in status column
  ---@type boolean
  sign = true,

  -- timer debounce
  ---@type integer
  debounce = 10,

  -- sign priority
  ---@type integer
  sign_priority = 40,

  -- show virtual text at the end of line
  ---@type boolean
  virtual_text = true,

  -- enable virtual text in insert mode
  ---@type boolean
  enable_in_insert = true,

  ignore = {
    clients = {},
    ft = {},
  },
}

return lightbulb
