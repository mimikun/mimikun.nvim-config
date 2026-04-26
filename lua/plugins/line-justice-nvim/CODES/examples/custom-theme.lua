-- examples/custom-theme.lua
--
-- This file demonstrates how to create and register a custom colour theme
-- for line-justice.nvim.
--
-- Drop it into your lazy.nvim plugins directory alongside line-justice, or
-- call the registration code in any init.lua / after/plugin file that loads
-- after line-justice.nvim.
--
-- ─────────────────────────────────────────────────────────────────────────────
-- HOW THEMES WORK
-- ─────────────────────────────────────────────────────────────────────────────
--
-- A theme is a plain Lua table — a LineJusticeThemeSpec — with the shape:
--
--   {
--     name        = "MyTheme",          -- unique name (case-sensitive)
--     description = "One sentence.",    -- shown in warnings/errors
--     author      = "Your Name",        -- optional credit
--     colors = {
--       CursorLine    = { fg = "#rrggbb", bold   = true },
--       AbsoluteAbove = { fg = "#rrggbb" },
--       AbsoluteBelow = { fg = "#rrggbb" },
--       RelativeAbove = { fg = "#rrggbb" },
--       RelativeBelow = { fg = "#rrggbb" },
--       WrappedLine   = { fg = "#rrggbb", italic = true },
--     },
--   }
--
-- All six color keys are recommended. Missing keys fall through to the
-- colorscheme auto-detect or the built-in FALLBACK (Horizon palette),
-- so you can supply only the keys you want to override.
--
-- Themes are registered via:
--   require("line-justice").themes.register(spec)
--
-- You can register as many themes as you like. Registration can happen at
-- any point — before or after setup() is called. If you call setup() after
-- registering, the theme name is available immediately. If you register after
-- setup(), call setup() again to pick up the new theme.
--
-- ─────────────────────────────────────────────────────────────────────────────
-- COLOR SLOT REFERENCE
-- ─────────────────────────────────────────────────────────────────────────────
--
--   CursorLine    — the line the cursor is on (typically bold + accent color)
--   AbsoluteAbove — absolute line numbers on lines ABOVE the cursor
--   AbsoluteBelow — absolute line numbers on lines BELOW the cursor
--   RelativeAbove — relative distance numbers on lines ABOVE the cursor
--   RelativeBelow — relative distance numbers on lines BELOW the cursor
--   WrappedLine   — the indicator character on soft-wrapped continuation lines
--
-- ─────────────────────────────────────────────────────────────────────────────
-- EXAMPLE THEMES
-- ─────────────────────────────────────────────────────────────────────────────

local lj = require("line-justice")

-- ── Example 1: Forest ─────────────────────────────────────────────────────
-- Deep greens and mossy tones. Great with Everforest, NeoSolarized, or any
-- nature-inspired colorscheme.

lj.themes.register({
  name = "Forest",
  description = "Deep greens and mossy tones for nature-inspired colorschemes.",
  author = "Your Name Here",
  colors = {
    CursorLine = { fg = "#a8ff78", bold = true },
    AbsoluteAbove = { fg = "#4a7c59" },
    AbsoluteBelow = { fg = "#2e5b3a" },
    RelativeAbove = { fg = "#6dbf8a" },
    RelativeBelow = { fg = "#4c9e6a" },
    WrappedLine = { fg = "#4a7c59", italic = true },
  },
})

-- ── Example 2: Ember ──────────────────────────────────────────────────────
-- Deep reds and burnt oranges. Pairs well with Monokai, Dracula, and
-- other high-contrast dark themes.

lj.themes.register({
  name = "Ember",
  description = "Deep reds and burnt oranges for high-contrast dark themes.",
  author = "Your Name Here",
  colors = {
    CursorLine = { fg = "#ff6b6b", bold = true },
    AbsoluteAbove = { fg = "#994444" },
    AbsoluteBelow = { fg = "#7a2e2e" },
    RelativeAbove = { fg = "#cc7755" },
    RelativeBelow = { fg = "#aa5533" },
    WrappedLine = { fg = "#994444", italic = true },
  },
})

-- ── Example 3: Grayscale ──────────────────────────────────────────────────
-- Pure greyscale for maximum neutrality. Works well in any colorscheme
-- where you want the line numbers to be purely functional.

lj.themes.register({
  name = "Grayscale",
  description = "Pure greyscale — functional and colorscheme-agnostic.",
  author = "Your Name Here",
  colors = {
    CursorLine = { fg = "#d0d0d0", bold = true },
    AbsoluteAbove = { fg = "#707070" },
    AbsoluteBelow = { fg = "#555555" },
    RelativeAbove = { fg = "#909090" },
    RelativeBelow = { fg = "#6a6a6a" },
    WrappedLine = { fg = "#707070", italic = true },
  },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- USING A CUSTOM THEME
-- ─────────────────────────────────────────────────────────────────────────────
--
-- After registering, pass the name to setup(), then wire the segment:

lj.setup({
  line_numbers = {
    theme = "Forest", -- <── your custom theme name here
  },
  wrapped_lines = {
    indicator = "Arrow", -- optional: show ↳ on wrapped lines
  },
})

require("statuscol").setup({
  segments = {
    { text = { lj.segment }, click = "v:lua.ScLa" },
  },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- CHECKING AVAILABLE THEMES
-- ─────────────────────────────────────────────────────────────────────────────
--
-- List all built-in and registered themes:
--
--   :lua print(vim.inspect(require("line-justice").themes.list()))
--
-- Output will include both built-ins and any custom registrations:
--   { "Dawn", "Ember", "Forest", "Grayscale", "Horizon", "Midnight" }
--
-- Check if a specific theme exists before using it:
--
--   :lua print(require("line-justice").themes.exists("Forest"))
--
-- ─────────────────────────────────────────────────────────────────────────────
-- SHIPPING A THEME AS A SEPARATE PLUGIN OR FILE
-- ─────────────────────────────────────────────────────────────────────────────
--
-- You can distribute themes as standalone Lua files or plugins. The only
-- requirement is that the file calls lj.themes.register() at load time.
--
-- Example standalone theme file (e.g. themes/my-theme.lua):
--
--   local ok, lj = pcall(require, "line-justice")
--   if not ok then return end  -- line-justice not installed; skip silently
--
--   lj.themes.register({
--     name        = "MyTheme",
--     description = "My personal colour palette.",
--     colors = { ... },
--   })
--
-- Load order tip: ensure line-justice.nvim loads before your theme file.
-- With lazy.nvim, add `dependencies = { "zaakiy/line-justice.nvim" }` to your
-- theme plugin spec.
--
-- ─────────────────────────────────────────────────────────────────────────────
