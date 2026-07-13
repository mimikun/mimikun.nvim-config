---@type render.md.sign.Config
local sign = {
  -- Turn on / off sign rendering.
  ---@field enabled? boolean
  enabled = true,

  -- Priority to assign to sign.
  ---@field priority? integer
  priority = nil,

  -- Applies to background of sign text.
  ---@field highlight? string
  highlight = "RenderMarkdownSign",
}

return sign
