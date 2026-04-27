---@type OctoConfig
local opts = {
  -- "telescope" | "fzf-lua" | "snacks" | "default"
  ---@type OctoPickers
  picker = "telescope",

  ---@type OctoPickerConfig
  picker_config = require("plugins.octo-nvim.opts.picker_config"),

  -- order to try remotes
  ---@type table
  default_remote = {
    "upstream",
    "origin",
  },

  -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `merge`, `rebase` or `squash`
  ---@type OctoMergeMethod
  default_merge_method = "merge",

  -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
  ---@type boolean
  default_delete_branch = false,

  -- SSH aliases.
  -- e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`.
  -- The key part will be interpreted as an anchored Lua pattern.
  ---@type {[string]:string}
  ssh_aliases = {},

  -- marker for user reactions
  ---@type string
  reaction_viewer_hint_icon = " ",

  -- additional subcommands made available to `Octo` command
  ---@type table
  commands = {},

  -- Users for assignees or reviewers. Values: "search" | "mentionable" | "assignable"
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

  -- bare Octo command opens picker of commands
  -- shows a list of builtin actions when no action is provided
  ---@type boolean
  enable_builtin = true,

  -- number of lines around commented lines
  ---@type number
  snippet_context_lines = 4,

  -- Command to use when calling Github CLI
  ---@type string
  gh_cmd = "gh",

  -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
  ---@type (table<string, string|integer>)|(fun(): table<string, string|integer>)
  gh_env = {},

  -- timeout for requests between the remote server
  ---@type number
  timeout = 5000,

  -- use projects v2 for the `Octo card ...` command by default.
  -- Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
  ---@type boolean
  default_to_projects_v2 = false,

  ---@type OctoMissingScopeConfig
  suppress_missing_scope = {
    projects_v2 = false,
  },

  ---@type OctoConfigUi
  ui = {
    -- show "modified" marks on the sign column
    use_signcolumn = false,

    -- show "modified" marks on the status column
    use_statuscolumn = true,

    use_foldtext = true,
  },
  ---@type OctoConfigIssues
  issues = {
    -- criteria to sort results of `Octo issue list`
    order_by = {
      -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      field = "CREATED_AT",

      -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
      direction = "DESC",
    },
  },
  ---@type OctoConfigDiscussions
  discussions = {
    order_by = {
      field = "CREATED_AT",
      direction = "DESC",
    },
  },
  ---@type OctoConfigNotifications
  notifications = {
    -- show notifications for current repo only
    current_repo_only = false,
  },
  ---@type OctoConfigReviews
  reviews = {
    -- automatically show comment threads on cursor move
    auto_show_threads = true,

    -- focus right buffer on diff open
    focus = "right",
  },
  ---@type OctoConfigRuns
  runs = {
    icons = {
      pending = "🕖",
      in_progress = "🔄",
      failed = "❌",
      succeeded = "",
      skipped = "⏩",
      cancelled = "✖",
    },
  },
  ---@type OctoConfigPR
  pull_requests = {
    -- criteria to sort the results of `Octo pr list`
    order_by = {
      -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      field = "CREATED_AT",

      -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
      direction = "DESC",
    },
    -- always give prompt to select base remote repo when creating PRs
    always_select_remote_on_create = false,

    -- sets branch name to be the name for the PR
    use_branch_name_as_title = false,
  },
  ---@type OctoConfigFilePanel
  file_panel = {
    -- changed files panel rows
    size = 10,

    -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
    use_icons = true,
  },
  -- used for highlight groups (see Colors section below)
  ---@type OctoConfigColors
  colors = {
    white = "#ffffff",
    grey = "#2A354C",
    black = "#000000",
    red = "#fdb8c0",
    dark_red = "#da3633",
    green = "#acf2bd",
    dark_green = "#238636",
    yellow = "#d3c846",
    dark_yellow = "#735c0f",
    blue = "#58A6FF",
    dark_blue = "#0366d6",
    purple = "#6f42c1",
  },

  -- disable default mappings if true, but will still adapt user mappings
  ---@type boolean
  mappings_disable_default = false,

  ---@type { [OctoMappingsWindow]: OctoMappingsList}
  mappings = require("plugins.octo-nvim.opts.mappings"),

  ---@type OctoConfigPoll
  poll = {
    -- opt-in polling for remote changes
    enabled = false,

    -- polling interval in milliseconds (default: 10s)
    interval = 10000,

    -- notify when a buffer is auto-refreshed
    notify_on_refresh = true,

    -- notify when remote changed but buffer has local edits
    notify_on_change = true,
  },

  ---@type OctoConfigSearch
  search = {
    -- key is a qualifier, value is an array table or a function returning a table
    completion_overrides = {},
  },

  ---@type OctoConfigDebug
  debug = {
    notify_missing_timeline_items = false,
  },
}

return opts
