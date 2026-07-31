---@class UIState
---@field current_view string
---@field line_map table<number, table>
---@field on_select fun(item: table|nil)|nil
---@field on_panel_open fun()|nil
---@field on_panel_close fun()|nil
---@field on_panel_next_tab fun()|nil
---@field on_panel_prev_tab fun()|nil

---@type UIState
local state = {
  current_view = "",
  line_map = {},
  on_select = nil,
  on_panel_open = nil,
  on_panel_close = nil,
  on_panel_next_tab = nil,
  on_panel_prev_tab = nil,
}

return state
