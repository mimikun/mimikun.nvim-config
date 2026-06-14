-- UI configuration
---@type fyler.UiConfig
local ui = {
  ---@type fyler.HiddenItemsConfig
  hidden_items = {
    -- Toggleable pre-defined switches (e.g. 'dotfiles' to hide files starting with a dot).
    ---@type string[]
    switches = {
      "dotfiles",
    },

    -- Toggleable patterns (Lua patterns matched against the full path).
    ---@type string[]
    patterns = {},

    -- Always visible items matching these patterns, even if they would normally be hidden.
    ---@type string[]
    always_visible = {},

    -- Always hide items matching these patterns, even if they would normally be visible.
    ---@type string[]
    always_hidden = {},
  },

  -- Whether to draw indent guides at each depth level.
  ---@type boolean
  indent_guides = false,
}

return ui
