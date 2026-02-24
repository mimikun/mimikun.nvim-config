---@type tokyonight.Config
local opts = {
  -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  style = "moon",
  -- The theme is used when the background is set to light
  light_style = "day",
  -- Enable this to disable setting the background color
  --- NOTE: use xiyaowong/transparent.nvim
  transparent = vim.g.transparent_enabled,
  -- Configure the colors used when opening a `:terminal` in Neovim
  terminal_colors = true,
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    -- style for sidebars, see below
    sidebars = "dark",
    -- style for floating windows
    floats = "dark",
  },

  -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  day_brightness = 0.3,

  -- dims inactive windows
  dim_inactive = false,

  -- When `true`, section headers in the lualine theme will be bold
  lualine_bold = false,

  -- When set to true, the theme will be cached for better performance
  cache = true,

  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
}

return opts
