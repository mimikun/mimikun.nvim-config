---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>c",
    ":Calcium<CR>",
    mode = {
      "n",
      "v",
    },
    desc = "Calculate",
    silent = true,
  },
}

return keys
