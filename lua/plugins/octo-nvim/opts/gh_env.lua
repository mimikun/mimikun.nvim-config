-- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
---@type (table<string, string | integer>) | (fun(): table<string, string | integer>)
local gh_env = {}

return gh_env
