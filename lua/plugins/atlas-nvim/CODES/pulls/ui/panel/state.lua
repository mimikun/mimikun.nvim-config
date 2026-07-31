---@alias PullsCurrentPanel "pr"|"repo"

---@class PullsRootPanelState
---@field current_panel PullsCurrentPanel
local M = {
  current_panel = "pr",
}

function M.reset()
  M.current_panel = "pr"
end

return M
