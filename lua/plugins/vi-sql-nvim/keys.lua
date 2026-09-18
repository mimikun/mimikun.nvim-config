---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Qo",
    "<cmd>ViSQL<cr>",
    desc = "vi-sql: Open",
    silent = true,
  },
  {
    "<leader>Qj",
    "<cmd>ViSQLJump<cr>",
    desc = "vi-sql: jump to table",
    silent = true,
  },
}

return keys
