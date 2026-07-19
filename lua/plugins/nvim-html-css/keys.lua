---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>cp",
    "<cmd>HtmlCssPeek<CR>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Peek CSS source",
    silent = true,
  },
}

return keys
