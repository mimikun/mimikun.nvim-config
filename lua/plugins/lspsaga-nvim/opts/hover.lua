---@type LspsagaConfig.Hover
local hover = {
  -- Defines float window width
  ---@type number
  max_width = 0.9,

  -- Defines float window height
  ---@type number
  max_height = 0.8,

  -- Key for opening links
  ---@type string
  open_link = "gx",

  -- Cmd for opening links
  ---@type string
  open_cmd = "!chrome",
}

return hover
