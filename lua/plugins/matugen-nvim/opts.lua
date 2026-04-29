---@type table
local opts = {
  colors_path = "~/.config/matugen/colors.json",

  watch = true,

  -- OKLCH lightness offset on backgrounds.
  -- Positive = lighter editor bg.
  brightness = 0.03,

  -- OKLCH lightness offset on accents/foreground (independent of brightness).
  contrast = 0,

  -- Offset for sidebar panels (neo-tree, snacks explorer, mini.files) relative to the editor bg.
  -- Positive = brighter than editor, negative = darker.
  sidebar_brightness = 0.02,

  -- How aggressively to pull named accent hues toward the wallpaper's primary.
  -- 0 = canonical hues, ~30 = strongly tinted.
  harmonize = 15,

  -- Minimum L* contrast between accents and bg.
  -- Bumped up if matugen hands us a primary that's too close to the surface lightness.
  min_contrast = 0.45,

  -- Override any palette key after derivation.
  -- Same names as in palette.lua.
  overrides = {
    --str = "#c8d3a0",
  },
}

return opts
