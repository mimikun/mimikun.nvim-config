---@type render.md.sign.Config
local sign = {
  -- Turn on / off sign rendering.
  ---@type boolean
  enabled = true,

  -- Priority to assign to sign.
  ---@type integer
  priority = nil,

  -- Applies to background of sign text.
  ---@type string
  highlight = "RenderMarkdownSign",
}

return sign
