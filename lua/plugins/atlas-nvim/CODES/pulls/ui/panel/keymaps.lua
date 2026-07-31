local M = {}

local panel_state = require("atlas.pulls.ui.panel.state")

---@return table
local function active_keymaps()
  if panel_state.current_panel == "repo" then
    return require("atlas.pulls.ui.panel.repo.keymaps")
  end
  return require("atlas.pulls.ui.panel.pr.keymaps")
end

---@param buf integer
function M.register(buf)
  require("atlas.pulls.ui.panel.pr.keymaps").remove(buf)
  require("atlas.pulls.ui.panel.repo.keymaps").remove(buf)
  active_keymaps().register(buf)
end

---@param buf integer
function M.remove(buf)
  require("atlas.pulls.ui.panel.pr.keymaps").remove(buf)
  require("atlas.pulls.ui.panel.repo.keymaps").remove(buf)
end

return M
