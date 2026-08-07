---@type table
local opts = {
  -- Core settings
  save_path = vim.fn.stdpath("data") .. "/dooing_todos.json",

  -- Pretty-print JSON output (requires jq or python)
  pretty_print_json = false,

  -- Timestamp settings
  timestamp = {
    -- Show relative timestamps (e.g., @5m ago, @2h ago)
    enabled = true,
  },

  -- Window settings
  window = require("plugins.dooing.opts.window"),

  -- To-do formatting
  formatting = require("plugins.dooing.opts.formatting"),

  -- Quick keys window
  quick_keys = true,

  notes = {
    icon = "📓",
  },

  scratchpad = {
    syntax_highlight = "markdown",
  },

  -- Per-project todos
  per_project = require("plugins.dooing.opts.per_project"),

  -- Nested tasks
  nested_tasks = require("plugins.dooing.opts.nested_tasks"),

  -- Due date notifications
  due_notifications = require("plugins.dooing.opts.due_notifications"),

  -- Keymaps
  keymaps = require("plugins.dooing.opts.keymaps"),

  calendar = require("plugins.dooing.opts.calendar"),

  -- Priority settings
  priorities = require("plugins.dooing.opts.priorities"),
  priority_groups = require("plugins.dooing.opts.priority_groups"),

  hour_score_value = 1 / 8,
  done_sort_by_completed_time = false,
}

return opts
