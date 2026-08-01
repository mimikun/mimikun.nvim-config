---@alias Palette { base: string, surface: string, overlay: string, muted: string, subtle: string, text: string, love: string, gold: string, rose: string, pine: string, foam: string, iris: string }
---@alias PaletteColor "base" | "surface" | "overlay" | "muted" | "subtle" | "text" | "love" | "gold" | "rose" | "pine" | "foam" | "iris" | "highlight_low" | "highlight_med" | "highlight_high"
---@alias Highlight { link: string, inherit: boolean } | { fg: string, bg: string, sp: string, bold: boolean, italic: boolean, undercurl: boolean, underline: boolean, underdouble: boolean, underdotted: boolean, underdashed: boolean, strikethrough: boolean, inherit: boolean }

---@type Options
local opts = {
  ---Set the desired variant:
  ---"auto" will follow the vim background, defaulting to `dark_variant` or "main" for dark and "dawn" for light.
  ---@type string| "auto" | "main" | "moon" | "dawn"
  variant = "auto",

  extend_background_behind_borders = true,
  ---Set the desired dark variant when `options.variant` is set to "auto".
  ---@type string| "auto" | "main" | "moon" | "dawn"
  dark_variant = "main",

  ---Differentiate between active and inactive windows and panels.
  dim_inactive_windows = false,

  ---Extend background behind borders. Appearance differs based on which
  ---border characters you are using.
  extend_background_behind_borders = true,

  enable = {
    legacy_highlights = true,
    migrations = true,
    terminal = true,
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  ---@type table<string, table<string, string>>
  palette = {
    -- Override the builtin palette per variant
    -- moon = {
    --     base = '#18191a',
    --     overlay = '#363738',
    -- },
  },

  ---@type table<string, string | PaletteColor>
  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    ok = "leaf",
    warn = "gold",
    note = "pine",
    todo = "rose",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    ---@type string | PaletteColor
    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "leaf",

    ---@deprecated Replaced by `options.highlight_groups["Normal"]`
    -- background = "base",
    ---@deprecated Replaced by `options.highlight_groups["Comment"]`
    -- comment = "subtle",
    ---@deprecated Replaced by `options.highlight_groups["@punctuation"]`
    -- punctuation = "muted",
    ---@deprecated Expects a table with values h1...h6
    -- headings = "text",
  },

  -- Highlight groups are extended (merged) by default.
  -- Disable this per group via `inherit = false`
  ---@type table<string, Highlight>
  highlight_groups = {
    Comment = {
      fg = "foam",
    },
    StatusLine = {
      fg = "love",
      bg = "love",
      blend = 15,
    },
    VertSplit = {
      fg = "muted",
      bg = "muted",
    },
    Visual = {
      fg = "base",
      bg = "text",
      inherit = false,
    },
  },

  ---Called before each highlight group, before setting the highlight.
  ---@param group string
  ---@param highlight Highlight
  ---@param palette Palette
  ---@diagnostic disable-next-line: unused-local
  before_highlight = function(_group, _highlight, _palette)
    -- Disable all undercurls
    -- if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
}

local readme = {

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true, -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },
}

return opts
