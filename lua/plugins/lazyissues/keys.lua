---@type LazyKeysSpec[]
local keys = {
  {
    -- TODO: it
    "<leader>i",
    "<cmd>LazyIssues<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    {
      desc = "Issues",
      --expr = true,
      --noremap = true,
      silent = true,
    },
  },
}

return keys
