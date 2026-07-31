local M = {}

---@param buf integer
function M.register(buf)
  require("atlas.issues.ui.panel.issue.keymaps").remove(buf)
  require("atlas.issues.ui.panel.issue.keymaps").register(buf)
end

---@param buf integer
function M.remove(buf)
  require("atlas.issues.ui.panel.issue.keymaps").remove(buf)
end

return M
