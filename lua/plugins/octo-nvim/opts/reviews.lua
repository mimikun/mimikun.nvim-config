---@type OctoConfigReviews
local reviews = {
  -- automatically show comment threads on cursor move
  ---@type boolean
  auto_show_threads = true,

  -- focus right buffer on diff open
  ---@type OctoSplit | string | "right" | "left"
  focus = "right",

  -- show virtual text with comment count and date
  ---@type boolean
  show_virtual_text = true,
}

return reviews
