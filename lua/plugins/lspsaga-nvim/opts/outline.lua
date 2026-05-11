---@type LspsagaConfig.Outline
local outline = {
  -- window position
  ---@type string | "left" | "right"
  win_position = "right",

  -- window width
  ---@type integer
  win_width = 30,

  -- auto preview when cursor moved in outline window
  ---@type boolean
  auto_preview = true,

  -- show detail
  ---@type boolean
  detail = true,

  -- auto close itself when outline window is last window
  ---@type boolean
  auto_close = true,

  -- close after jump
  ---@type boolean
  close_after_jump = false,

  -- when is float above options will ignored
  ---@type string | "float" | "normal"
  layout = "normal",

  -- Max height of outline window
  ---@field max_height number
  max_height = 0.5,

  -- Width of left panel
  ---@field left_width number
  left_width = 0.3,

  ---@type LspsagaConfig.Outline.Keys
  keys = {
    -- toggle or jump
    ---@type string | string[]
    toggle_or_jump = "o",

    -- quit
    ---@type string | string[]
    quit = "q",

    -- jump to pos even on expand/collapse node
    ---@type string | string[]
    jump = "e",
  },
}

return outline
