local log = {
  -- Whether to enable logging
  enabled = false,

  -- The maximum file size allowed for the log file before it gets cleaned
  -- This size is in Mebibytes (MiB), A.K.A. 1MiB -> 1024KiB
  max_size = 1.1,

  -- The directory where the log file will be written to
  logpath = vim.fn.stdpath("state"),

  --snacks = {
  --  enabled = false,
  --  style = "fancy",
  --},
}

return log
