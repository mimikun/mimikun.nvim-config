---@type table An option to customize the popup for the `Hardtime report`.
local ui = {
  enter = true,
  focusable = true,
  border = {
    style = "rounded",
    text = {
      top = "Hardtime Report",
      top_align = "center",
    },
  },
  position = "50%",
  size = {
    width = "40%",
    height = "60%",
  },
}

return ui
