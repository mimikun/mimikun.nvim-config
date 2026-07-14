local M = {}

function M.paste(direction)
  local key = direction == "before" and "P" or "p"
  local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

return M
