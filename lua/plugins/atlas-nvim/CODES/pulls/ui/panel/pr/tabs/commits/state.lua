---@class PullsCommitsTabState
---@field commits PullsCommit[]|"loading"|string|nil
---@field status_by_hash table<string, "successful"|"failed"|"inprogress"|"stopped"|"unknown"|"loading"|nil>
---@field url_by_hash table<string, string|nil>
local M = {
  commits = nil,
  status_by_hash = {},
  url_by_hash = {},
}

function M.reset()
  M.commits = nil
  M.status_by_hash = {}
  M.url_by_hash = {}
end

---@return boolean
function M.any_loading()
  if M.commits == "loading" then
    return true
  end
  for _, v in pairs(M.status_by_hash) do
    if v == "loading" then
      return true
    end
  end
  return false
end

return M
