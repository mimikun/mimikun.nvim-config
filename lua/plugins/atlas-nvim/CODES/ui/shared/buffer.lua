local M = {}

---@param buf integer|nil
---@return boolean
function M.valid(buf)
  return buf ~= nil and vim.api.nvim_buf_is_valid(buf)
end

---@param name string
---@param filetype string
---@return integer
function M.create(name, filetype)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, name)
  vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
  vim.api.nvim_set_option_value("syntax", "OFF", { buf = buf })
  pcall(vim.treesitter.stop, buf)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  return buf
end

---@param buf integer|nil
function M.delete(buf)
  if M.valid(buf) then
    pcall(vim.api.nvim_buf_delete, buf, { force = true })
  end
end

return M
