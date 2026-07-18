-- The highlight style to use for underlines ('undercurl' or 'underline')
---@type rustowl.HighlightStyles
local highlight_styles = {
  -- Highlight style for lifetime (default: 'underline')
  ---@type string
  definitely_live = "underline",

  -- Highlight style for maybe initialized (default: 'undercurl')
  ---@type string
  maybe_initialized = "undercurl",

  -- Highlight style for immutable borrow (default: 'underline')
  ---@type string
  imm_borrow = "underline",

  -- Highlight style for mutable borrow (default: 'underline')
  ---@type string
  mut_borrow = "underline",

  -- Highlight style for move (default: 'underline')
  ---@type string
  move = "underline",

  -- Highlight style for function call (default: 'underline')
  ---@type string
  call = "underline",

  ---@type string
  shared_mut = "undercurl",

  -- Highlight style for outlive (default: 'undercurl')
  ---@type string
  outlive = "undercurl",
}

return highlight_styles
