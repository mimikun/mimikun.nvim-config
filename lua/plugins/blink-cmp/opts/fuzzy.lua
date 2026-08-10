---@type blink.cmp.FuzzyConfig
local fuzzy = {
  -- The rust library is built by the `build` function in init.lua.
  -- 'prefer_rust_with_warning' falls back to the lua implementation and warns
  -- when the library is missing, which is what we want to notice a failed build.
  ---@type "prefer_rust_with_warning" | "prefer_rust" | "rust" | "lua"
  implementation = "prefer_rust_with_warning",

  -- Tracks the most recently/frequently used items and boosts their score
  ---@type blink.cmp.FuzzyConfigFrecency
  frecency = {
    ---@type boolean
    enabled = true,
  },

  -- Boosts the score of items matching nearby words
  ---@type boolean
  use_proximity = true,
}

return fuzzy
