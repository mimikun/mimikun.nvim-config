-- The options passed to the |nvim_open_win|.
-- 'width' and 'height' cannot be specified.
---@type vim.api.keyset.win_config
local win_opts = {
  relative = "cursor",
  row = 1,
  col = 1,
  style = "minimal",
  border = "rounded",
}

return win_opts
