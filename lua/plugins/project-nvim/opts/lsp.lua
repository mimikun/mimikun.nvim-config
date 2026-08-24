local lsp = {
  -- Whether to enable LSP-based detection
  enabled = true,

  -- LSP clients to ignore
  ignore = {},

  -- If `true`, no pattern matching will be used as a backup.
  -- WARNING: ENABLE AT YOUR OWN DISCRETION!!!!
  no_fallback = false,

  -- Whether to double-check the LSP root with the pattern matching method.
  use_pattern_matching = false,
}

return lsp
