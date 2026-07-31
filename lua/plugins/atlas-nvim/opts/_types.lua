-- Keymaps

---@alias AtlasKeymapValue string|string[]|false|nil

---@alias AtlasPullsProviderId "bitbucket"|"github"|"gitlab"
---@alias AtlasIssuesProviderId "jira"|"github"|"gitlab"

-- Pulls Provider Config

---@class AtlasPullsViewConfig
---@field name string
---@field key string|nil
---@field layout "compact"|"plain"|nil

---@class AtlasIssuesViewConfig
---@field name string
---@field key string|nil
---@field layout "plain"|"compact"|nil

---@class AtlasPullsRepoConfig
---@field settings table<string, AtlasPullsRepoSettings>|nil
---@field paths table<string, string>|nil

---@class AtlasPullsRepoSettings
---@field readme string|nil
---@field pr_template string|nil

---@class AtlasPullsDiffExplorerConfig
---@field grouped boolean|nil
---@field hidden boolean|nil
---@field show_commits boolean|nil
---@field width integer|nil
---@field initial_focus "explorer"|"diff"|nil
---@field ignore string[]|nil

---@alias AtlasPullsDiffOpenCommand "AtlasDiff"|"DiffviewOpen"|"CodeDiff"

---@class AtlasPullsDiffConfig
---@field open_cmd AtlasPullsDiffOpenCommand|string|nil
---@field layout "side-by-side"|"inline"|nil
---@field compact boolean|nil
---@field explorer AtlasPullsDiffExplorerConfig|nil

---@class AtlasPullsCustomActionContext
---@field repo_path string|nil
---@field pr PullRequest
---@field user PullsUser|nil

---@class AtlasPullsCustomAction
---@field id string
---@field label string
---@field confirmation boolean|nil
---@field run fun(pr: PullRequest, ctx: AtlasPullsCustomActionContext, done: fun(ok: boolean|nil, message: string|nil))

-- Configs

---@class AtlasPullsProviders
---@field bitbucket AtlasBitbucketConfig|nil
---@field github AtlasGitHubConfig|nil
---@field gitlab AtlasGitLabPullsConfig|nil

---@class AtlasIssuesProviders
---@field jira AtlasJiraIssuesConfig|nil
---@field github AtlasGitHubIssuesConfig|nil
---@field gitlab AtlasGitLabIssuesConfig|nil

---@class AtlasPullsConfig
---@field repo_config AtlasPullsRepoConfig|nil
---@field diff AtlasPullsDiffConfig|nil
---@field custom_actions AtlasPullsCustomAction[]|nil
---@field providers AtlasPullsProviders|nil

---@class AtlasIssuesCustomActionContext
---@field issue Issue|nil
---@field user IssueUser|nil

---@class AtlasIssuesCustomAction
---@field id string
---@field label string
---@field confirmation boolean|nil
---@field run fun(issue: Issue, ctx: AtlasIssuesCustomActionContext, done: fun(ok: boolean|nil, message: string|nil))

---@class AtlasIssuesConfig
---@field max_results number|nil
---@field with_relationships boolean|nil
---@field custom_actions AtlasIssuesCustomAction[]|nil
---@field providers AtlasIssuesProviders|nil

-- Config

---@class AtlasConfig
---@field pulls AtlasPullsConfig|nil
---@field issues AtlasIssuesConfig|nil
---@field keymaps AtlasKeymapsConfig|nil  -- see core/keymaps.lua for type
