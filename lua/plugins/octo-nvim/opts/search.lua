---@type OctoConfigSearch
local search = {
  -- key is a qualifier, value is an array table or a function returning a table
  ---@type table<string, string[] | fun(argLead: string, cmdLine: string): string[]>
  completion_overrides = {},
}

return search
