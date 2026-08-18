---@type OctoPickerConfig
local picker_config = {
  -- only used by "fzf-lua" picker for now
  ---@type boolean
  use_emojis = false,

  -- Whether to use static search results (true) or dynamic search (false)
  ---@type boolean
  search_static = true,

  -- mappings for the pickers
  ---@type OctoPickerMappings
  mappings = {
    ---@type OctoPickerMapping
    open_in_browser = {
      ---@type string
      lhs = "<C-b>",

      ---@type string
      desc = "open issue in browser",
    },

    ---@type OctoPickerMapping
    copy_url = {
      ---@type string
      lhs = "<C-y>",

      ---@type string
      desc = "copy url to system clipboard",
    },

    copy_sha = {
      ---@type string
      lhs = "<C-e>",

      ---@type string
      desc = "copy commit SHA to system clipboard",
    },

    ---@type OctoPickerMapping
    checkout_pr = {
      ---@type string
      lhs = "<C-o>",

      ---@type string
      desc = "checkout pull request",
    },

    ---@type OctoPickerMapping
    merge_pr = {
      ---@type string
      lhs = "<C-r>",

      ---@type string
      desc = "merge pull request",
    },
  },

  -- snacks specific config
  ---@type OctoPickerConfigSnacks
  snacks = {
    -- Initialize actions as empty arrays

    -- custom actions for specific snacks pickers (array of tables)
    ---@type table
    actions = {
      -- actions for the issues picker
      ---@type OctoSnacksActionList
      issues = {
        --{
        --  name = "my_issue_action",
        --  fn = function(_picker, item)
        --    print("Issue action:", vim.inspect(item))
        --  end,
        --  lhs = "<leader>a",
        --  desc = "My custom issue action",
        --},
      },

      -- actions for the pull requests picker
      ---@type OctoSnacksActionList
      pull_requests = {
        --{
        --  name = "my_pr_action",
        --  fn = function(_picker, item)
        --    print("PR action:", vim.inspect(item))
        --  end,
        --  lhs = "<leader>b",
        --  desc = "My custom PR action",
        --},
      },

      -- actions for the notifications picker
      ---@type OctoSnacksActionList
      notifications = {},

      -- actions for the issue templates picker
      ---@type OctoSnacksActionList
      issue_templates = {},

      -- actions for the search picker
      ---@type OctoSnacksActionList
      search = {},

      -- ... add actions for other pickers as needed
      ---@type OctoSnacksActionList
      changed_files = {},

      ---@type OctoSnacksActionList
      commits = {},

      ---@type OctoSnacksActionList
      review_commits = {},
    },
  },
}

return picker_config
