-- Configuration for headings.
---@type vimdoc.headings
local headings = {
  --- When `false`, headings don't get rendered.
  ---@type boolean
  enable = true,

  --- Configuration for === headings.
  ---@type headings.opts
  heading_1 = {
    -- Text to show in the **right** side of the heading.
    ---@type string
    sign = " ⣾⣿⠛⣿⣷ ",

    -- Highlight group for `sign`.
    ---@type string
    sign_hl = "Palette1Inv",

    -- Highlight group for `marker`.
    ---@type string
    marker_hl = "Palette1Bg",

    -- Primary highlight group.
    -- Used by other `*_hl` option(s) when a value isn't given.
    ---@type string
    hl = "Palette1Fg",

    -- Text used to replace `=`/`-` parts.
    -- On level 3 & 4 headings it covers the whitespace instead.
    ---@type string
    --marker=

    --- Text to add before & after the `sign`.
    ---@type [ string, string ]
    --label=

    -- Highlight group for the parts of the label.
    ---@type [ string, string ]
    --label_hl=
  },

  --- Configuration for --- headings.
  ---@type headings.opts
  heading_2 = {
    sign = " ⣠⠞⠛⠳⣄ ",
    sign_hl = "Palette2Inv",

    marker_hl = "Palette2",
    hl = "Palette2Fg",
  },

  --- Configuration for ABC headings.
  ---@type headings.opts
  heading_3 = {
    sign = " ⣯⣤⠛⣤⣽ ",
    sign_hl = "Palette3Inv",

    marker_hl = "Palette3",
    hl = "Palette3",
  },

  --- Configuration for A ~ headings.
  ---@type headings.opts
  heading_4 = {
    sign = " ⠓⣠⣿⣄⠚ ",
    sign_hl = "Palette4Inv",

    marker_hl = "Palette4",
    hl = "Palette4",
  },
}

return headings
