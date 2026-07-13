---@type render.md.checkbox.Config
local checkbox = {
  -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
  -- There are two special states for unchecked & checked defined in the markdown grammar.

  -- Turn on / off checkbox state rendering.
  enabled = true,

  -- Additional modes to render checkboxes.
  render_modes = false,

  -- Render the bullet point before the checkbox.
  ---@type boolean
  bullet = false,

  -- Padding to add to the left of checkboxes.
  ---@type number
  left_pad = 0,

  -- Padding to add to the right of checkboxes.
  ---@type integer
  right_pad = 1,

  ---@type render.md.checkbox.component.UserConfig
  unchecked = {
    -- Replaces '[ ]' of 'task_list_marker_unchecked'.
    icon = "󰄱 ",

    -- Highlight for the unchecked icon.
    highlight = "RenderMarkdownUnchecked",

    -- Highlight for item associated with unchecked checkbox.
    scope_highlight = nil,
  },

  ---@type render.md.checkbox.component.UserConfig
  checked = {
    -- Replaces '[x]' of 'task_list_marker_checked'.
    icon = "󰱒 ",

    -- Highlight for the checked icon.
    highlight = "RenderMarkdownChecked",

    -- Highlight for item associated with checked checkbox.
    scope_highlight = nil,
  },

  -- Define custom checkbox states, more involved, not part of the markdown grammar.
  -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
  -- The key is for healthcheck and to allow users to change its values, value type below.
  -- raw: matched against the raw text of a 'shortcut_link'
  -- rendered: replaces the 'raw' value when rendering
  -- highlight: highlight for the 'rendered' icon
  -- scope_highlight: optional highlight for item associated with custom checkbox
  ---@type table<string, render.md.checkbox.custom.UserConfig>
  custom = {
    todo = {
      raw = "[-]",
      rendered = "󰥔 ",
      highlight = "RenderMarkdownTodo",
      scope_highlight = nil,
    },
  },

  -- Priority to assign to scope highlight.
  ---@type integer
  scope_priority = nil,
}

return checkbox
