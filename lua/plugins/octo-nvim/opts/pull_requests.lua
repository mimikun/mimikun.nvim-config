---@type OctoConfigPR
local pull_requests = {
  -- criteria to sort the results of `Octo pr list`
  ---@type OctoConfigOrderBy
  order_by = {
    -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
    ---@type string
    field = "CREATED_AT",

    -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    ---@type string | "ASC" | "DESC"
    direction = "DESC",
  },

  -- always give prompt to select base remote repo when creating PRs
  ---@type boolean
  always_select_remote_on_create = false,

  -- sets branch name to be the name for the PR
  ---@type boolean
  use_branch_name_as_title = false,
}

return pull_requests
