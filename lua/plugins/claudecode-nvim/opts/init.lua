---@module "claudecode.config"
---@type ClaudeCodeConfig
local opts = {
  -- NOTE: Server Configuration

  -- Port range configuration
  ---@type ClaudeCodePortRange
  port_range = {
    ---@type integer
    min = 10000,

    ---@type integer
    max = 65535,
  },

  ---@type boolean
  auto_start = true,

  -- Custom environment variables for Claude terminal
  ---@type table<string, string>
  env = {
    --it
  },

  -- Log level type alias
  ---@type ClaudeCodeLogLevel | string | "trace" | "debug" | "info" | "warn" | "error"
  log_level = "info",

  -- Custom terminal command (default: "claude")
  -- For local installations: "~/.claude/local/claude"
  -- For native binary: use output from 'which claude'
  ---@type string | nil
  terminal_cmd = "~/.local/bin/claude",

  -- NOTE: Send/Focus Behavior

  -- When true, successful sends focus the in-editor Claude terminal if already connected.
  -- NOTE: this only works for in-editor providers (snacks/native);
  -- it has no effect with provider = "none"/"external" (Claude runs outside Neovim).
  -- For those, hook the `User ClaudeCodeSendComplete` event (see Events).

  ---@type boolean
  focus_after_send = false,

  -- NOTE: Selection Tracking

  ---@type boolean
  track_selection = true,

  -- Milliseconds to wait before demoting a visual selection
  ---@type number
  visual_demotion_delay_ms = 50,

  -- Milliseconds to wait after connection before sending queued @ mentions
  ---@type number
  connection_wait_delay = 600,

  -- Maximum time to wait for Claude Code to connect (milliseconds)
  ---@type number
  connection_timeout = 10000,

  -- Maximum time to keep @ mentions in queue (milliseconds)
  ---@type number
  queue_timeout = 5000,
  -- `value` is passed verbatim to `claude --model`.
  -- These short aliases resolve to the latest model on the Anthropic API, so labels stay version-free to avoid going stale on every release.

  ---@type ClaudeCodeModelOption[]
  models = require("plugins.claudecode-nvim.opts.models"),

  -- NOTE: Terminal Configuration

  ---@type ClaudeCodeTerminalConfig
  terminal = require("plugins.claudecode-nvim.opts.terminal"),

  -- NOTE: Diff Integration

  ---@type ClaudeCodeDiffOptions
  diff_opts = require("plugins.claudecode-nvim.opts.diff_opts"),

  ---@field disable_broadcast_debouncing? boolean
  ---@field enable_broadcast_debouncing_in_tests? boolean
}

return opts
