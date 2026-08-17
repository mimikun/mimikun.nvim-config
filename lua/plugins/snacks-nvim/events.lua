---@type table
local events = {
  -- BufReadPre: lazy.nvim replays the event to newly created augroups after
  -- loading, so snacks' own BufReadPre/BufReadPost handlers still fire for the
  -- file opened at startup. Required for `bigfile` and `quickfile`.
  "BufReadPre",
  -- VeryLazy: `nvim` without a file argument never fires BufReadPre, so the
  -- UIEnter-driven modules (input, scope, picker, ...) need this as well.
  "VeryLazy",
}

return events
