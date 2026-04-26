-- Drop this into your lazy.nvim plugins directory, e.g.
-- ~/.config/nvim/lua/plugins/line-justice.lua
--
-- ─────────────────────────────────────────────────────────────────────────────
-- HOW IT WORKS
-- ─────────────────────────────────────────────────────────────────────────────
--
-- line-justice is a statuscol.nvim segment provider. It owns colour themes,
-- highlight group registration, number formatting, and wrapped-line rendering.
-- It does NOT call statuscol.setup() — you wire the segment into your own
-- statuscol config. This means it never conflicts with your statuscol setup.
--
-- Recommended wiring (fold + diagnostic signs + other signs + line-justice):
--
--   local lj      = require("line-justice")
--   local builtin = require("statuscol.builtin")
--   lj.setup()
--
--   require("statuscol").setup({
--     relculright = true,
--     segments = {
--       { text = { builtin.foldfunc },                                                    click = "v:lua.ScFa" },
--       { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },       click = "v:lua.ScSa" },
--       { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
--       { text = { lj.segment },                                                          click = "v:lua.ScLa" },
--     },
--   })
--
-- setup() automatically enables vim.o.number and vim.o.relativenumber — both
-- are required for statuscol to populate args.lnum and args.relnum correctly.
--
-- ─────────────────────────────────────────────────────────────────────────────
-- WRAPPED-LINE INDICATOR
-- ─────────────────────────────────────────────────────────────────────────────
--
-- When a line is too long and wraps, NeoVim renders continuation lines in
-- the gutter. line-justice can show a small indicator character there,
-- centred in the gutter width, to visually distinguish wrapped continuations
-- from real lines.
--
-- wrapped_lines.indicator  (string)
--   "None"     — blank gutter, no character shown
--   "Arrow"    — ↳  classic turn-down arrow
--   "Chevron"  — ›  single right-pointing chevron
--   "Dot"      — ·  middle dot / interpunct
--   "Ellipsis" — …  horizontal ellipsis
--   "Bar"      — │  thin vertical bar (default)
--   "Custom"   — use whatever you set in wrapped_lines.custom
--
-- wrapped_lines.custom  (string)
--   Only used when indicator = "Custom".
--   Examples: "»", "⤷", "▸", "→", "╰"
--
-- ─────────────────────────────────────────────────────────────────────────────
-- COLOUR THEMES
-- ─────────────────────────────────────────────────────────────────────────────
--
-- line_numbers.theme     (string | nil)
--   "Horizon" — built-in palette: cool blues above, greens below (default)
--   "Dawn"    — warm amber and rose tones
--   "Midnight"— cool monochrome blue-greys
--   nil       — auto-detect from your active colorscheme
--
-- line_numbers.overrides (table | nil)
--   Per-key tweaks on top of the theme or auto-detect.
--   Keys: CursorLine, AbsoluteAbove, AbsoluteBelow,
--         RelativeAbove, RelativeBelow, WrappedLine
--
-- ─────────────────────────────────────────────────────────────────────────────

-- ── line-justice spec ─────────────────────────────────────────────────────────
--
-- lazy = false ensures setup() runs at startup so M.segment is populated
-- before statuscol.setup() reads it.
--
-- statuscol.nvim is listed as a dependency so lazy.nvim loads it first.
-- All statuscol configuration lives here — do NOT add a separate statuscol
-- plugin spec that also calls statuscol.setup(), or the two calls will
-- conflict and whichever runs last will overwrite the other.

return {
  {
    "zaakiy/line-justice.nvim",
    dependencies = { "luukvbaal/statuscol.nvim" },
    lazy = false,

    -- ── Option A: defaults — Horizon theme, Bar wrapped indicator ─────────────
    opts = {
      line_numbers = { theme = "Horizon" },
      wrapped_lines = { indicator = "Bar" },
    },

    config = function(_, opts)
      local lj = require("line-justice")
      local builtin = require("statuscol.builtin")
      lj.setup(opts)

      -- Wire the segment into statuscol alongside fold and sign segments.
      -- Place other segments around lj.segment freely — line-justice never
      -- calls statuscol.setup() itself, so there is no conflict.
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
          { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
          { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
          { text = { lj.segment }, click = "v:lua.ScLa" },
        },
      })
    end,

    -- ── Option B: Arrow indicator (↳) ─────────────────────────────────────────
    -- opts = {
    --   line_numbers  = { theme = "Horizon" },
    --   wrapped_lines = { indicator = "Arrow" },  -- ↳
    -- },

    -- ── Option C: Chevron indicator (›) ───────────────────────────────────────
    -- opts = {
    --   line_numbers  = { theme = "Horizon" },
    --   wrapped_lines = { indicator = "Chevron" }, -- ›
    -- },

    -- ── Option D: Dot indicator (·) ───────────────────────────────────────────
    -- opts = {
    --   line_numbers  = { theme = "Horizon" },
    --   wrapped_lines = { indicator = "Dot" },     -- ·
    -- },

    -- ── Option E: Ellipsis indicator (…) ──────────────────────────────────────
    -- opts = {
    --   line_numbers  = { theme = "Horizon" },
    --   wrapped_lines = { indicator = "Ellipsis" }, -- …
    -- },

    -- ── Option F: Custom indicator ────────────────────────────────────────────
    -- opts = {
    --   line_numbers  = { theme = "Horizon" },
    --   wrapped_lines = { indicator = "Custom", custom = "⤷" },
    -- },

    -- ── Option G: auto-detect colours ─────────────────────────────────────────
    -- opts = {
    --   line_numbers  = { theme = nil },           -- derive from colorscheme
    --   wrapped_lines = { indicator = "Arrow" },
    -- },

    -- ── Option H: full line-justice config ────────────────────────────────────
    -- opts = {
    --   line_numbers = {
    --     theme = "Horizon",
    --     overrides = {
    --       CursorLine    = { fg = "#ff9e64", bold = true },
    --       AbsoluteAbove = { fg = "#565f89" },
    --       AbsoluteBelow = { fg = "#41664f" },
    --       RelativeAbove = { fg = "#7b9ac7" },
    --       RelativeBelow = { fg = "#6aa781" },
    --       WrappedLine   = { fg = "#565f89", italic = true },
    --     },
    --   },
    --   wrapped_lines = { indicator = "Custom", custom = "╰" },
    -- },
  },

  -- ── Placing other segments alongside line-justice ─────────────────────────
  --
  -- Because line-justice doesn't own statuscol.setup(), you have full control
  -- over what else appears in the statuscolumn. Common examples:
  --
  -- Minimal — just line-justice, no fold or sign columns:
  --
  --   require("statuscol").setup({
  --     segments = {
  --       { text = { lj.segment }, click = "v:lua.ScLa" },
  --     },
  --   })
  --
  -- Gitsigns sign column to the LEFT of line-justice numbers:
  --
  --   require("statuscol").setup({
  --     segments = {
  --       { text = { "%s" },        click = "v:lua.ScSa" }, -- sign column
  --       { text = { lj.segment },  click = "v:lua.ScLa" }, -- line-justice
  --     },
  --   })
  --
  -- Fold column to the RIGHT of line-justice numbers:
  --
  --   require("statuscol").setup({
  --     segments = {
  --       { text = { lj.segment }, click = "v:lua.ScLa" }, -- line-justice
  --       { text = { "%C" },        click = "v:lua.ScFa" }, -- fold column
  --     },
  --   })
  --
  -- Any statuscol top-level option (relculright, bt_ignore, ft_ignore, etc.)
  -- can be passed freely — line-justice does not touch them:
  --
  --   require("statuscol").setup({
  --     relculright = true,
  --     bt_ignore   = { "nofile" },
  --     ft_ignore   = { "NvimTree", "neo-tree" },
  --     segments    = {
  --       { text = { lj.segment }, click = "v:lua.ScLa" },
  --     },
  --   })
}
