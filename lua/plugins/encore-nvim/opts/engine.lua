local engine = {
  -- number of actions kept in memory
  ---@type integer
  capacity = 20000,

  persist = {
    -- save the action log to disk, restored on startup
    ---@type boolean
    enabled = true,

    -- JSON log file
    ---@type string
    path = vim.fn.stdpath("data") .. "/encore/history.json",

    -- max entries kept on disk
    ---@type integer
    max = 20000,

    -- seconds between dirty saves (also saved on exit)
    ---@type integer
    interval = 60,

    -- safety net: keep only the newest entries that fit this many encoded bytes (guards against runaway bloat)
    max_bytes = 64 * 1024 * 1024,
  },
}

return engine
