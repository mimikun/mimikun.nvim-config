-- Highlight configuration
local highlights = {
  -- Line-level highlights: accepts highlight group names (e.g., "DiffAdd") or color values (e.g., "#2ea043")

  -- Line-level insertions (base color)
  line_insert = "DiffAdd",

  -- Line-level deletions (base color)
  line_delete = "DiffDelete",

  -- Character-level highlights: accepts highlight group names or color values
  -- If specified, these override char_brightness calculation

  -- Character-level insertions (if nil, derived from line_insert with char_brightness)
  char_insert = nil,

  -- Character-level deletions (if nil, derived from line_delete with char_brightness)
  char_delete = nil,

  -- Brightness multiplier for character-level highlights (only used if char_insert/char_delete are nil)
  -- nil = auto-detect based on background (1.4 for dark, 0.92 for light)
  -- Set explicit value to override: char_brightness = 1.2
  char_brightness = nil,

  -- Conflict sign highlights (for merge conflict views)
  -- Accepts highlight group names (e.g., "DiagnosticWarn") or color values (e.g., "#f0883e")
  -- nil = use default fallback chain (GitSigns* -> DiagnosticSign* -> hardcoded colors)

  -- Unresolved conflict sign (default: DiagnosticSignWarn -> #f0883e)
  conflict_sign = nil,

  -- Resolved conflict sign (default: Comment -> #6e7681)
  conflict_sign_resolved = nil,

  -- Accepted side sign (default: GitSignsAdd -> DiagnosticSignOk -> #3fb950)
  conflict_sign_accepted = nil,

  -- Rejected side sign (default: GitSignsDelete -> DiagnosticSignError -> #f85149)
  conflict_sign_rejected = nil,
}

return highlights
