---@type SemgrepConfig
local opts = {
  -- executable
  -- Executable used to invoke semgrep.
  ---@type string
  cmd = "semgrep",

  -- config value(s);
  -- string or string[] e.g. {"p/ci","auto"}
  -- Value(s) passed to `--config` (e.g. "auto", "p/ci").
  ---@type string | string[]
  config = "auto",

  -- extra CLI args appended to every scan
  -- Additional CLI args appended to every scan.
  ---@type string[]
  extra_args = {},

  -- Re-scan the current file on `BufWritePost`.
  ---@type boolean
  scan_on_save = false,

  -- apply available fixes automatically after a scan
  -- When true, applying a fix happens automatically after scan.
  ---@type boolean
  autofix = false,

  -- show a doc-link marker as virtual text
  -- Show documentation links as virtual text on the finding line.
  ---@type boolean
  virtual_text_links = true,

  -- Prefer the telescope picker when available; else quickfix.
  ---@type boolean
  use_telescope = true,

  -- Name of the diagnostic namespace.
  ---@type string
  diagnostic_namespace = "semgrep",
}

return opts
