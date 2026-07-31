---@class IssuesRootPanelState
---@field current_issue Issue|nil
---@field current_tab string
---@field line_map table<integer, table>
local M = {
  current_issue = nil,
  current_tab = "overview",
  line_map = {},
}

function M.reset()
  M.current_issue = nil
  M.current_tab = "overview"
  M.line_map = {}
end

return M
