---@type table
local opts = {
  -- Auto-connect to a named connection on open (default: nil)
  connection = nil,

  -- Press this inside vi-sql to hide the window (change to taste)
  -- Key to hide the window from inside vi-sql without ending the session
  -- Set to nil to disable.
  -- Any key works; pick one that vi-sql doesn't use.
  hide_key = "<C-q>",

  -- Floating window size as a fraction of the editor (default: 0.9)
  width = 0.9,
  height = 0.9,
}

return opts
