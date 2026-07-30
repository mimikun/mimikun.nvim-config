---@type ReviewQuickCommentsConfig
local quick_comments = {
  ---@type ReviewQuickCommentsKeymaps
  keymaps = {
    -- Keymap to add a quick comment
    ---@type string | nil
    add = nil,

    -- Keymap to toggle the quick comments panel
    ---@type string | nil
    toggle_panel = nil,
  },

  ---@type ReviewQuickCommentsPanelConfig
  panel = {
    -- Panel width in columns
    ---@type number
    width = 65,

    -- Panel position
    ---@type string | "left" | "right"
    position = "right",
  },

  ---@type ReviewQuickCommentsSignsConfig
  signs = {
    -- Whether to show gutter signs
    ---@type boolean
    enabled = true,
  },
}

return quick_comments
