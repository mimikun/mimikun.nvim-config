---@type OctoPickerConfig
local picker_config = {
  -- only used by "fzf-lua" picker for now
  use_emojis = false,

  -- Whether to use static search results (true) or dynamic search (false)
  search_static = true,

  -- mappings for the pickers
  mappings = {
    open_in_browser = {
      lhs = "<C-b>",
      desc = "open issue in browser",
    },
    copy_url = {
      lhs = "<C-y>",
      desc = "copy url to system clipboard",
    },
    copy_sha = {
      lhs = "<C-e>",
      desc = "copy commit SHA to system clipboard",
    },
    checkout_pr = {
      lhs = "<C-o>",
      desc = "checkout pull request",
    },
    merge_pr = {
      lhs = "<C-r>",
      desc = "merge pull request",
    },
  },

  -- snacks specific config
  snacks = {
    -- Initialize actions as empty arrays
    -- custom actions for specific snacks pickers (array of tables)
    actions = {
      -- actions for the issues picker
      issues = {
        --{
        --  name = "my_issue_action",
        --  fn = function(picker, item)
        --    print("Issue action:", vim.inspect(item))
        --  end,
        --  lhs = "<leader>a",
        --  desc = "My custom issue action",
        --},
      },

      -- actions for the pull requests picker
      pull_requests = {
        --{
        --  name = "my_pr_action",
        --  fn = function(picker, item)
        --    print("PR action:", vim.inspect(item))
        --  end,
        --  lhs = "<leader>b",
        --  desc = "My custom PR action",
        --},
      },

      -- actions for the notifications picker
      notifications = {},

      -- actions for the issue templates picker
      issue_templates = {},

      -- actions for the search picker
      search = {},

      -- ... add actions for other pickers as needed
      changed_files = {},
      commits = {},
      review_commits = {},
    },
  },
}

return picker_config
