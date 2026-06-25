-- LSP progress tracking (enabled by default, set to false to disable)
local progress = {
  -- General progress options
  -- Poll rate: 0 = immediate, >0 = Hz, false = disabled
  poll_rate = 0,

  -- Suppress new messages while in insert mode
  suppress_on_insert = false,

  -- Ignore new tasks that are already complete
  ignore_done_already = false,

  -- Ignore new tasks that don't contain a message
  ignore_empty_message = false,

  -- How to group progress messages (default: by client name)
  notification_group = function(msg)
    return msg.client.name
  end,

  -- List of clients to ignore
  ignore = {},

  -- Module-specific configuration
  modules = {
    -- LSP progress module configuration
    -- Set to `nil` to disable LSP progress tracking entirely
    lsp = {
      -- Configure the LSP progress ring buffer size
      progress_ringbuf_size = 0,

      -- Log $/progress handler invocations (for debugging)
      log_handler = false,
    },
  },

  -- Display options
  display = {
    -- How many messages to show at once
    render_limit = 16,
    -- How long completed messages persist (seconds)
    done_ttl = 3,
    -- Icon for completed tasks
    done_icon = "✔",
    -- Icon for in-progress tasks (animated)
    progress_icon = {
      "dots",
    },
    -- How long in-progress messages persist
    progress_ttl = math.huge,
    -- Ordering priority
    priority = 30,
    -- Omit from history
    skip_history = true,
  },
}

return progress
