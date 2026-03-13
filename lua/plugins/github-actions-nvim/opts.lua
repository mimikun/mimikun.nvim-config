---@type GithubActionsConfig
local opts = {
  actions = {
    enabled = true,
    icons = {
      outdated = "",
      latest = "",
      error = "",
    },
  },
  ---@type HistoryOptions
  history = {
    icons = {
      success = "✓",
      failure = "✗",
      cancelled = "⊘",
      skipped = "⊘",
      in_progress = "⊙",
      queued = "○",
      waiting = "○",
      unknown = "?",
    },
    ---@type HistoryBufferOptions
    buffer = {
      ---@type BufferOpenOptions
      history = {
        ---@type string "tab" | "vsplit" | "split" | "current"
        open_mode = "tab",
        ---@type boolean
        buflisted = true,
        ---@type table<string, any>
        window_options = {
          wrap = true,
          number = true,
          cursorline = true,
        },
      },
      ---@type BufferOpenOptions
      logs = {
        ---@type string "tab" | "vsplit" | "split" | "current"
        open_mode = "vsplit",
        ---@type boolean
        buflisted = true,
        ---@type table<string, any>
        window_options = {
          wrap = false,
          number = false,
        },
      },
    },
  },
}

return opts
