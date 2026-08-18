---@type OctoConfigDiscussions
local discussions = {
  ---@type OctoConfigOrderBy
  order_by = {
    ---@type string
    field = "CREATED_AT",

    ---@type string | "ASC" | "DESC"
    direction = "DESC",
  },
}

return discussions
