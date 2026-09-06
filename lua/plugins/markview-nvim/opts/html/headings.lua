-- Configuration for headings(e.g. `<h1>`).
---@type markview.config.html.headings
local headings = {
  -- Enable rendering of heading tags.
  ---@type boolean
  enable = true,

  -- Configuration for `<h[n]></h[n]>`.
  ---@type table
  heading_1 = {
    hl_group = "MarkviewPalette1Bg",
  },
  heading_2 = {
    hl_group = "MarkviewPalette2Bg",
  },
  heading_3 = {
    hl_group = "MarkviewPalette3Bg",
  },
  heading_4 = {
    hl_group = "MarkviewPalette4Bg",
  },
  heading_5 = {
    hl_group = "MarkviewPalette5Bg",
  },
  heading_6 = {
    hl_group = "MarkviewPalette6Bg",
  },
}

return headings
