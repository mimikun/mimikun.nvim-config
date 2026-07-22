---@type table
local opts = {
  ui = {
    -- the format of the last commit date
    date_format = "%Y-%m-%d",
  },

  -- the timeout for the analysis for each plugin in ms
  analyzing_timeout = 2000,

  -- the list of plugins to be ignored
  ignored = {
    -- e.g. "orphans.nvim", due to the implementation problem, only plugin name is supported, more formats to be supported in the future release
    "orphans.nvim",
  },

  debug = false,
}

return opts
