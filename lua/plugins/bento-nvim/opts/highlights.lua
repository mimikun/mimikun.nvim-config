-- Highlight groups
local highlights = {
  -- Current buffer filename (in last editor window)
  current = "Bold",

  -- Active buffers visible in other windows
  active = "Normal",

  -- Inactive/hidden buffer filenames
  inactive = "Comment",

  -- Modified/unsaved buffer filenames and dashes
  modified = "DiagnosticWarn",

  -- Inactive buffer dashes in collapsed state
  inactive_dash = "Comment",

  -- Label for last-accessed buffer (when keymap is registered)
  previous = "Search",

  -- Default label highlight (actions can override via hl option)
  label = "DiagnosticVirtualTextHint",

  -- Labels in collapsed "full" mode
  label_minimal = "Visual",

  -- Menu window background
  window_bg = "BentoNormal",

  -- Pagination indicators (● ○ ○ for floating, ❮/❯ for tabline)
  page_indicator = "Comment",

  -- Separator between buffer components in tabline
  separator = "Comment",
}

return highlights
