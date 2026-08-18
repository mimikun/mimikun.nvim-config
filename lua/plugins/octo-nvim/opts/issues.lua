---@type OctoConfigIssues
local issues = {
  -- criteria to sort results of `Octo issue list`
  ---@type OctoConfigOrderBy
  order_by = {
    -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
    ---@type string
    field = "CREATED_AT",

    -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    ---@type string | "ASC" | "DESC"
    direction = "DESC",
  },
}

return issues
