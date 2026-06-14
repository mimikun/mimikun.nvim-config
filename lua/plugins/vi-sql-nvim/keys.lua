---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>vs",
    "<cmd>ViSQL<cr>",
    desc = "vi-sql: Open",
    silent = true,
  },
  {
    "<leader>vj",
    "<cmd>ViSQLJump<cr>",
    desc = "vi-sql: jump to table",
    silent = true,
  },
}

return keys
