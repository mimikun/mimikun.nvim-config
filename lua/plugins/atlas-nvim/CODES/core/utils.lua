local M = {}

---@param v any
---@return table|nil
function M.as_table(v)
  if type(v) == "table" then
    return v
  end
  return nil
end

return M
