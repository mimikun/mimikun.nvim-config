---@class PullsActivityTabState
---@field activity PullsActivityEntry[]|"loading"|string|nil
local M = {
  activity = nil,
}

function M.reset()
  M.activity = nil
end

---@return boolean
function M.any_loading()
  return M.activity == "loading"
end

return M
