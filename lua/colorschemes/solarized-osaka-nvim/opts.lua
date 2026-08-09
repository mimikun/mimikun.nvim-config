---@type Config
local opts = {
  -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  ---@type string | "storm" | "night" | "day"
  style = "",
  -- The theme is used when the background is set to light
  light_style = "light",
  -- Enable this to disable setting the background color
  -- TODO: use transparent.nvim
  transparent = true,
  -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  terminal_colors = true,
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = {
      italic = true,
    },
    keywords = {
      italic = true,
    },
    functions = {},
    variables = {},
    -- Background styles.
    -- Can be "dark", "transparent" or "normal"
    -- style for sidebars, see below
    ---@type string | "dark" | "transparent" | "normal"
    sidebars = "dark",
    -- style for floating windows
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
  -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  day_brightness = 0.3, 
  -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  hide_inactive_statusline = false, 
  -- dims inactive windows
  dim_inactive = false, 
  -- When `true`, section headers in the lualine theme will be bold
  lualine_bold = false, 

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param hl Highlights
  ---@param c ColorScheme
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
  -- can be light/dark/auto. 
  -- When auto, background will be set to vim.o.background
  use_background = true, 

  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    -- enable all plugins when not using lazy.nvim
    -- set to false to manually enable/disable plugins
    all = package.loaded.lazy == nil,
    -- uses your plugin manager to automatically enable needed plugins
    -- currently only lazy.nvim is supported
    auto = true,
    -- add any plugins here that you want to enable
    -- for all possible plugins, see:
    --   * https://github.com/craftzdog/solarized-osaka.nvim/tree/main/lua/solarized-osaka/groups
    -- flash = true,
  },
}

return opts
