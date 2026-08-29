---@type table
local opts = {
  -- Character shown before locked buffer names
  lock_char = "🔒",

  -- Set via api.set_default_action()
  default_action = nil,

  -- Max buffers (nil = unlimited)
  ---@type number | nil
  max_open_buffers = nil,

  -- Metric for buffer deletion (see below)
  ---@type string | "recency_access" | "recency_edit" | "frecency_access" | "frecency_edit"
  buffer_deletion_metric = "frecency_access",

  -- Notify when deleting a buffer (false for silent deletion)
  buffer_notify_on_delete = true,

  -- Buffer ordering:
  -- nil (insertion order), "access", "edit", "filename", or "directory"
  ---@type string | "access" | "edit" | "filename" | "directory" | nil
  ordering_metric = "access",

  -- Sort locked buffers to the top
  locked_first = false,

  -- Whether to map a key to the last accessed buffer (besides main_keymap)
  -- If true, last-accessed buffer gets a normal label (keymap still works)
  map_last_accessed = false,

  ui = require("plugins.bento-nvim.opts.ui"),

  -- Highlight groups
  highlights = require("plugins.bento-nvim.opts.highlights"),
}

return opts
