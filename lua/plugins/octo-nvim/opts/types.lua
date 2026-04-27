---@alias OctoMappingsWindow "issue" | "pull_request" | "review_thread" | "submit_win" | "review_diff" | "file_panel" | "repo" | "notification" | "runs" | "discussion"
---@alias OctoMappingsList { [string]: table}
---@alias OctoPickers "telescope" | "fzf-lua" | "snacks" | "default"
---@alias OctoSplit "right" | "left"
---@alias OctoMergeMethod "squash" | "rebase" | "merge"

---@class OctoPickerMapping
---@field lhs string
---@field desc string

---@class OctoPickerMappings
---@field open_in_browser OctoPickerMapping
---@field copy_url OctoPickerMapping
---@field checkout_pr OctoPickerMapping
---@field merge_pr OctoPickerMapping

-- Type for a single action definition within the array
---@class OctoSnacksActionItem
---@field name string -- Mandatory identifier for the action
---@field fn function -- The function to execute
---@field lhs? string -- Optional keybinding
---@field desc? string -- Optional description
---@field mode? string[] -- Optional modes (e.g., {"n", "i"})

-- Type for the array of actions for a specific picker
---@alias OctoSnacksActionList OctoSnacksActionItem[]

---@class OctoPickerConfigSnacks
---@field actions { -- Actions are now arrays of tables
---    issues?: OctoSnacksActionList,
---    pull_requests?: OctoSnacksActionList,
---    notifications?: OctoSnacksActionList,
---    issue_templates?: OctoSnacksActionList,
---    search?: OctoSnacksActionList,
---    changed_files?: OctoSnacksActionList,
---    commits?: OctoSnacksActionList,
---    review_commits?: OctoSnacksActionList,
---  }

---@class OctoPickerConfig
---@field use_emojis boolean -- Used by fzf-lua
---@field mappings OctoPickerMappings
---@field snacks OctoPickerConfigSnacks -- Snacks specific config
---@field search_static boolean -- Whether to use static search results (true) or dynamic search (false)

---@class OctoConfigColors
---@field white string
---@field grey string
---@field black string
---@field red string
---@field dark_red string
---@field green string
---@field dark_green string
---@field yellow string
---@field dark_yellow string
---@field blue string
---@field dark_blue string
---@field purple string

---@class OctoConfigFilePanel
---@field size number
---@field use_icons boolean

---@class OctoConfigUi
---@field use_signcolumn boolean
---@field use_statuscolumn boolean
---@field use_foldtext boolean

---@class OctoConfigIssues
---@field order_by OctoConfigOrderBy

---@class OctoConfigReviews
---@field auto_show_threads boolean
---@field focus OctoSplit

---@class OctoConfigDiscussions
---@field order_by OctoConfigOrderBy

---@class OctoConfigWorkflowIcons
---@field pending string
---@field skipped string
---@field in_progress string
---@field failed string
---@field succeeded string
---@field cancelled string

---@class OctoConfigRuns
---@field icons OctoConfigWorkflowIcons

---@class OctoConfigNotifications
---@field current_repo_only boolean

---@class OctoConfigPR
---@field order_by OctoConfigOrderBy
---@field always_select_remote_on_create boolean
---@field use_branch_name_as_title boolean

---@class OctoConfigOrderBy
---@field field string
---@field direction "ASC" | "DESC"

---@class OctoMissingScopeConfig
---@field projects_v2 boolean

---@class OctoConfigPoll
---@field enabled boolean
---@field interval number
---@field notify_on_refresh boolean
---@field notify_on_change boolean

---@class OctoConfigDebug
---@field notify_missing_timeline_items boolean

---@class OctoConfigSearch
---@field completion_overrides table<string, string[]|fun(argLead: string, cmdLine: string): string[]>
