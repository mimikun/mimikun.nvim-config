-- Octo configuration settings
---@type OctoConfig
local opts = {
  -- or "fzf-lua" or "snacks" or "default"
  ---@type OctoPickers
  picker = "telescope",

  ---@type OctoPickerConfig
  picker_config = require("plugins.octo-nvim.opts.picker_config"),

  -- order to try remotes
  ---@type table
  default_remote = require("plugins.octo-nvim.opts.default_remote"),

  -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `merge`, `rebase` or `squash`
  ---@type OctoMergeMethod
  default_merge_method = "merge",

  -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker
  -- (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
  ---@type boolean
  default_delete_branch = false,

  -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`.
  -- The key part will be interpreted as an anchored Lua pattern.
  ---@type {[string]:string}
  ssh_aliases = require("plugins.octo-nvim.opts.ssh_aliases"),

  -- marker for user reactions
  ---@type string
  reaction_viewer_hint_icon = " ",

  -- additional subcommands made available to `Octo` command
  ---@type table
  commands = require("plugins.octo-nvim.opts.commands"),

  -- Users for assignees or reviewers.
  -- Values: "search" | "mentionable" | "assignable"
  ---@type string
  users = "search",

  -- user icon
  ---@type string
  user_icon = " ",

  -- ghost icon
  ---@type string
  ghost_icon = "󰊠 ",

  -- copilot icon
  ---@type string
  copilot_icon = " ",

  ---@type string
  dependabot_icon = " ",

  ---@type string
  comment_icon = "▎",

  ---@type string
  outdated_icon = "󰅒 ",

  ---@type string
  resolved_icon = " ",

  ---@type string
  timeline_marker = " ",

  ---@type number
  timeline_indent = 2,

  ---@type boolean
  use_timeline_icons = true,

  ---@type table
  timeline_icons = require("plugins.octo-nvim.opts.timeline_icons"),

  -- bubble delimiter
  ---@type string
  right_bubble_delimiter = "",

  -- bubble delimiter
  ---@type string
  left_bubble_delimiter = "",

  -- GitHub Enterprise host
  ---@type string
  github_hostname = "",

  -- use local files on right side of reviews
  ---@type boolean
  use_local_fs = false,

  -- shows a list of builtin actions when no action is provided bare Octo command opens picker of commands
  ---@type boolean
  enable_builtin = true,

  -- number of lines around commented lines
  ---@type number
  snippet_context_lines = 4,

  -- Command to use when calling Github CLI
  ---@type string
  gh_cmd = "gh",

  -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
  ---@type (table<string, string | integer>) | (fun(): table<string, string | integer>)
  gh_env = require("plugins.octo-nvim.opts.gh_env"),

  -- timeout for requests between the remote server
  ---@type number
  timeout = 5000,

  -- use projects v2 for the `Octo card ...` command by default.
  -- Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
  ---@type boolean
  default_to_projects_v2 = false,

  ---@type OctoMissingScopeConfig
  suppress_missing_scope = require("plugins.octo-nvim.opts.suppress_missing_scope"),

  ---@type OctoConfigUi
  ui = require("plugins.octo-nvim.opts.ui"),

  ---@type OctoConfigIssues
  issues = require("plugins.octo-nvim.opts.issues"),

  ---@type OctoConfigDiscussions
  discussions = require("plugins.octo-nvim.opts.discussions"),

  ---@type OctoConfigNotifications
  notifications = require("plugins.octo-nvim.opts.notifications"),

  ---@type OctoConfigReviews
  reviews = require("plugins.octo-nvim.opts.reviews"),

  ---@type OctoConfigRuns
  runs = require("plugins.octo-nvim.opts.runs"),

  ---@type OctoConfigPR
  pull_requests = require("plugins.octo-nvim.opts.pull_requests"),

  ---@type OctoConfigFilePanel
  file_panel = require("plugins.octo-nvim.opts.file_panel"),

  ---@type OctoConfigColors
  colors = require("plugins.octo-nvim.opts.colors"),

  -- disable default mappings if true, but will still adapt user mappings
  ---@type boolean
  mappings_disable_default = false,

  ---@type { [OctoMappingsWindow]: OctoMappingsList}
  mappings = require("plugins.octo-nvim.opts.mappings"),

  ---@type OctoConfigPoll
  poll = require("plugins.octo-nvim.opts.poll"),

  ---@type OctoConfigSearch
  search = require("plugins.octo-nvim.opts.search"),

  ---@type OctoConfigDebug
  debug = require("plugins.octo-nvim.opts.debug"),
}

return opts
