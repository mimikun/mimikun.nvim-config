---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>kc",
    "<cmd>Codedocs<CR>",
    mode = {
      "n",
    },
    desc = "Codedocs: insert annotation",
    silent = true,
  },
}

return keys
