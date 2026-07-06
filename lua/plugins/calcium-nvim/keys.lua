---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>c",
    ":Calcium<CR>",
    mode = {
      "n",
      "v",
    },
    {
      desc = "Calculate",
      --expr = true,
      --noremap = true,
      silent = true,
    },
  },
}

return keys
