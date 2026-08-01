---@type Config
local opts = {
  -- The theme comes in two styles, `default` and `highContrast`.
  ---@type string | "default" | "highContrast"
  style = "default",

  -- Enable this to disable setting the background color.
  transparent = false,

  -- Configure the colors used when opening a `:terminal`.
  terminal_colors = true,

  styles = {

    -- Style to be applied to different syntax groups.
    comments = {
      italic = true,
    },
    keywords = {
      italic = true,
    },
    functions = {
      --it
    },
    variables = {
      --it
    },

    -- Background styles.
    -- Can be 'dark', 'transparent' or 'normal'.
    ---@type string | "dark" | "transparent" | "normal"
    sidebars = "dark",

    ---@type string | "dark" | "transparent" | "normal"
    floats = "dark",
  },

  -- Set a darker background on sidebar-like windows.
  sidebars = {
    "qf",
    "help",
    "vista_kind",
    "terminal",
    "packer",
  },

  -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead.
  -- Should work with the standard **StatusLine** and **LuaLine**.
  hide_inactive_statusline = false,

  --- Dims inactive windows.
  dim_inactive = false,

  -- When true, section headers in the lualine theme will be bold.
  lualine_bold = false,

  -- You can override specific color groups to use other groups or a hex color, function will be called with a ColorScheme table.
  ---@param colors ColorScheme
  ---@field on_colors fun(colors: ColorScheme)
  on_colors = function(_colors)
    --it
  end,

  --- You can override specific highlights to use other groups or a hex color, function will be called with a Highlights and ColorScheme table.
  ---@param highlights Highlights
  ---@param colors ColorScheme
  ---@field on_highlights fun(highlights: Highlights, colors: ColorScheme)
  on_highlights = function(_highlights, _colors)
    --it
  end,
}

return opts
