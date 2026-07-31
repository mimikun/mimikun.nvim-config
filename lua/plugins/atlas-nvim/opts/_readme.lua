local readme = {
  pulls = {
    providers = {
      ---@type AtlasBitbucketConfig
      bitbucket = {}, -- See configuration below
      ---@type AtlasGitHubConfig
      github = {}, -- See configuration below
      ---@type AtlasGitLabPullsConfig
      gitlab = {}, -- See configuration below
    },
  },
  issues = {
    providers = {
      ---@type AtlasJiraIssuesConfig
      jira = {}, -- See configuration below
      ---@type AtlasGitHubIssuesConfig
      github = {}, -- See configuration below
      ---@type AtlasGitLabIssuesConfig
      gitlab = {}, -- See configuration below
    },
  },
}
