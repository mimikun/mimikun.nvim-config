---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>cp",
    "<cmd>HtmlCssPeek<CR>",
    mode = {
      "n",
    },
    desc = "Peek CSS source",
    silent = true,
  },
}

return keys
