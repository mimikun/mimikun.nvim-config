---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>i",
    "<cmd>LazyIssues<cr>",
    mode = {
      "n",
    },
    desc = "Issues",
    silent = true,
  },
}

return keys
