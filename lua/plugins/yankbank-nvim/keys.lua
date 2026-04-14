---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>y",
    "<cmd>YankBank<CR>",
    mode = "n",
    { silent = true, noremap = true },
  },
}

return keys
